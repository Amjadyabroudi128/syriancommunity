import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syrianadmin/Screens/Celebrations/CelebrationView.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';


class EditCelebration extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  final String? oldUrl;

  const EditCelebration({Key? key, required this.DocID, required this.oldName, required this.oldDetail, this.oldUrl}) : super(key: key);

  @override
  State<EditCelebration> createState() => _EditCelebrationState();
}

class _EditCelebrationState extends State<EditCelebration> {
  TextEditingController celebrationName = TextEditingController();
  TextEditingController celebrationDetails = TextEditingController();
  String? url;
  File? file;
  void initState() {
    super.initState();
    celebrationName.text = widget.oldName;
    celebrationDetails.text = widget.oldDetail;
    url = widget.oldUrl;
  }
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
  final CollectionReference celebrations =
  FirebaseFirestore.instance.collection('Celebrations');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("adding celebrations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: url != null ? Image.network(url!,
                    height: MediaQuery.of(context).size.height * 0.40,
                    // fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ) : SizedBox.shrink()
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("celebration"),
              ),
              CustomTextForm(hinttext: "e.g: Christmas", myController: celebrationName),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Details"),
              ),
              CustomTextForm(hinttext: "what we do ", myController: celebrationDetails,
                maxLines: 7,),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CustomButton(
                    title: "celebration image",
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
                    onPressed: () async {
                      if(url == null ) {
                        await celebrations.doc(widget.DocID).update(
                          {
                            "name" : celebrationName.text,
                            "details" : celebrationDetails.text
                          }
                        );
                      } else {
                       await celebrations.doc(widget.DocID).update(
                            {
                              "name" : celebrationName.text,
                              "details" : celebrationDetails.text,
                              "image" : url
                            }
                        );
                      }

                      Navigator.of(context).pushNamed("celebrations");
                    },
                    title: "Edit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
