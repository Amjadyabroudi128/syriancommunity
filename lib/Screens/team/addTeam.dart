import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:image_picker/image_picker.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
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
  final CollectionReference members =
  FirebaseFirestore.instance.collection('members');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("adding team"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Padding(
                //   padding: EdgeInsets.only(left: 12, bottom: 10),
                //   child: Text("Name"),
                // ),
                padding(child: Text("Name")),
                CustomTextForm(hinttext: "name", myController: name),
                sizedBox(height: 20,),
                // const Padding(
                //   padding: EdgeInsets.only(left: 12, bottom: 10),
                //   child: Text("Details"),
                // ),
                padding(child: Text("Details")),
                CustomTextForm(maxLines: 5, hinttext: "details", myController: details),
                sizedBox(height: 12,),
                Center(
                  child: CustomButton(
                    title: "get image",
                    onPressed: () async {
                    await pickImage();
                      setState(() {
                      });
                    },
                  ),
                ),
                sizedBox(height: 15,),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                        if (url == null) {
                          await members.doc().set(
                              {
                                "name" : name.text,
                                "details" : details.text,
                              }
                          );
                          Navigator.pop(context);

                        } else {
                          await members.doc().set(
                              {
                                "name" : name.text,
                                "details" : details.text,
                                "image" : url,
                              }
                          );
                          Navigator.pop(context);

                        }

                        clearText();
                      },
                      title: "Submit"),
                )
              ],
            ),
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
