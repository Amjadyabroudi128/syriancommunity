import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';


class EditCommunity extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetails;

  const EditCommunity({Key? key,  required this.DocID,  required this.oldName,  required this.oldDetails,}) : super(key: key);

  @override
  State<EditCommunity> createState() => _EditCommunityState();
}

class _EditCommunityState extends State<EditCommunity> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();

  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetails;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit community "),
        centerTitle: true,
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
                    maxLines: 5,
                    hinttext: "details",
                    myController: details),
                SizedBox(height: 12,),
                SizedBox(height: 15,),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection("Community").doc(widget.DocID).update(
                            {
                              "name" : name.text,
                              "details" : details.text
                            }
                        );
                        Navigator.of(context).pushNamed("community");

                      },
                      title: "Edit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
