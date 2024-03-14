import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/themes/colors.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class addCommunity extends StatefulWidget {
  const addCommunity({Key? key}) : super(key: key);

  @override
  State<addCommunity> createState() => _addCommunityState();
}

class _addCommunityState extends State<addCommunity> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  File? file;
  String? url;
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageCamera = await picker.pickImage(source: ImageSource.gallery);
    if (imageCamera != null) {
      file = File(imageCamera.path);
      var imagename = basename(imageCamera.path);
      var refStorage = FirebaseStorage.instance.ref(imagename);
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
    }
  }
  final CollectionReference community =
  FirebaseFirestore.instance.collection('Community');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDetails),
      ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.name),),
              CustomTextForm(hinttext: "BreakFast Club", myController: name),
              sizedBox(),
              padding(
                child: Text(AppLocalizations.of(context)!.details),
              ),
              CustomTextForm(hinttext: "What we do ", myController: details, maxLines: 6,),
              sizedBox(),
              Center(
                child: CustomButton(
                  title: AppLocalizations.of(context)!.image,
                  onPressed: () async {
                    await pickImage();
                    setState(() {

                    });
                  },
                  color: ColorManager.addEdit,
                ),
              ),
              Center(
                child: CustomButton(onPressed: () async {
                  if(url == null) {
                 await   community.doc().set({
                      "name" : name.text,
                      "details" : details.text
                    });
                 Navigator.pushReplacementNamed(context, 'community');
                  } else {
                   await community.doc().set({
                      "name" : name.text,
                      "details" : details.text,
                      "image" : url,
                    });
                   Navigator.pushReplacementNamed(context, 'community');
                  }
                }
                , title: AppLocalizations.of(context)!.submit, color: ColorManager.addEdit,
                ),
              ),
            ],
          ),
        ),
      ),
      );
  }
  void clearText() {
    name.clear();
    details.clear();
  }
}
