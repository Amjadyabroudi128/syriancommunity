import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:path/path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/padding.dart';

import '../../components/TextField.dart';
class AddCelebration extends StatefulWidget {
  const AddCelebration({Key? key}) : super(key: key);

  @override
  State<AddCelebration> createState() => _AddCelebrationState();
}

class _AddCelebrationState extends State<AddCelebration> {
  TextEditingController celebrationName = TextEditingController();
  TextEditingController celebrationDetail = TextEditingController();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addCelebration),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              padding(child: Text(AppLocalizations.of(context)!.celebrations)),
              CustomTextForm(hinttext: "e.g: Christmas", myController: celebrationName),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.details),),
              CustomTextForm(hinttext: "what we do ", myController: celebrationDetail, maxLines: 7,),
              sizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CustomButton(
                    title: AppLocalizations.of(context)!.image,
                    onPressed: () async {
                      await pickImage();
                      setState(() {
                      });
                    },
                  ),
                ),
              ),
              Center(
                child: CustomButton(
                    onPressed: () async{
                      if (url == null ) {
                        await FirebaseFirestore.instance.collection("Celebrations").doc().set(
                            {
                              "name" : celebrationName.text,
                              "details" : celebrationDetail.text,
                            }
                        );
                      } else  {
                        await FirebaseFirestore.instance.collection("Celebrations").doc().set(
                            {
                              "name" : celebrationName.text,
                              "details" : celebrationDetail.text,
                              "image" : url
                            }
                        );
                      }
                      Navigator.of(context).pop();
                    }, title: AppLocalizations.of(context)!.submit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
