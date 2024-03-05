import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditCommunity extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetails;
  final String? oldUrl;
  const EditCommunity({Key? key, required this.DocID, required this.oldName, required this.oldDetails, this.oldUrl,}) : super(key: key);

  @override
  State<EditCommunity> createState() => _EditCommunityState();
}

class _EditCommunityState extends State<EditCommunity> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  String? url;
  File? file;
  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetails;
    url = widget.oldUrl;
  }
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
        title: Text("adding Community Details"),
      ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.name)),
              CustomTextForm(hinttext: "BreakFast Club", myController: name),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.details)),
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
                ),
              ),
              Center(
                child: CustomButton(onPressed: () async {
                  if(url == null) {
                  await community.doc(widget.DocID).update({
                      "name" : name.text,
                      "details" : details.text,
                    });
                  Navigator.pop(context);
                  } else {
                  await community.doc(widget.DocID).update({
                      "name" : name.text,
                      "details" : details.text,
                      "image" : url
                    });
                  Navigator.pop(context);
                  }
                }
                  , title: AppLocalizations.of(context)!.update,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


