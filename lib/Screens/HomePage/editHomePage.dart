import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';

class EditHome extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  const EditHome({Key? key, required this.DocID, required this.oldName, required this.oldDetail}) : super(key: key);

  @override
  State<EditHome> createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetail;
  }
  @override
  Widget build(BuildContext context) {
    final CollectionReference home =
    FirebaseFirestore.instance.collection('home');
    return Scaffold(
      appBar: AppBar(
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
                  myController: details,
                  maxLines: 6,
                ),
                SizedBox(height: 15,),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                        await home.doc(widget.DocID).update(
                          {
                            "name" : name.text,
                            "details" : details.text,
                          }
                        );
                        Navigator.of(context).pushNamed("homepage");
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