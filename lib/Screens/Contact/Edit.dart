import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  TextEditingController place = TextEditingController();
  TextEditingController road = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("adding contactDetails"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Add Contact info")),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("place"),
              ),
              CustomTextForm(hinttext: "e.g : Brighton college", myController: place),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("street name"),
              ),
              CustomTextForm(hinttext: "e.g: Eastern Road",  myController: road),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("city"),
              ),
              CustomTextForm(hinttext: "e.g: Brighton", myController: city),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("post code"),
              ),
              CustomTextForm(
                  hinttext: "e.g: BN2 OAL", myController: postcode),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("email"),
              ),
              CustomTextForm(
                  hinttext: "email", myController: email),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("phone"),
              ),
              CustomTextForm(
                  hinttext: "phone", myController: phone),
              SizedBox(height: 15,),

              Center(child:
              CustomButton(onPressed: () async {
                await FirebaseFirestore.instance.collection("contact").doc().update({
                  "place" : place.text,
                  "street name" : road.text,
                  "city" : city.text,
                  "post code" : postcode.text,
                  "email" : email.text,
                  "phone" : phone.text
                });
                clearText();
              }, title: "update"))
            ],
          ),
        ),
      ),
    );
  }
  void clearText() {
    place.clear();
    road.clear();
    city.clear();
    postcode.clear();
    email.clear();
  }
}
