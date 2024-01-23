import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';

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
      file = File(imageCamera!.path);
      var imagename = basename(imageCamera!.path);
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
        centerTitle: true,
        title: Text("adding Community Details"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Add Community info ")),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("name"),
              ),
              CustomTextForm(hinttext: "BreakFast Club", myController: name),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Details"),
              ),
              CustomTextForm(hinttext: "What we do ", myController: details, maxLines: 6,),
              SizedBox(height: 15,),
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
              Center(
                child: CustomButton(onPressed: () async {
                  if(url == null) {
                 await   community.doc().set({
                      "name" : name.text,
                      "details" : details.text
                    });
                  } else {
                   await community.doc().set({
                      "name" : name.text,
                      "details" : details.text,
                      "image" : url
                    });
                   Navigator.of(context).pushNamed("community");
                  }

                }
                , title: "Submit",
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
