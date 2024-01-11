import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
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
      file = File(imageCamera!.path);
      var imagename = basename(imageCamera!.path);
      var refStorage = FirebaseStorage.instance.ref(imagename);
      await refStorage.putFile(file!);
       url = await refStorage.getDownloadURL();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("adding team"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text("Name"),
                ),
                CustomTextForm(
                    hinttext: "name",
                    myController: name),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text("Details"),
                ),
                CustomTextForm(
                    hinttext: "details",
                    myController: details),
                SizedBox(height: 12,),
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
                // if (url != null) Image.network("https://firebasestorage.googleapis.com/v0/b/syriancommunity-5239d.appspot.com/o/Fathi_Khalil.jpg?alt=media&token=5b3ea083-6c67-499c-b528-33c46cffe528"),
                SizedBox(height: 15,),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection("members").doc().set(
                            {
                              "name" : name.text,
                              "details" : details.text,
                              "image" : url,
                            }
                        );
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
