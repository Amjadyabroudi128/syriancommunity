import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddContactDetails extends StatefulWidget {
  const AddContactDetails({Key? key}) : super(key: key);

  @override
  State<AddContactDetails> createState() => _AddContactDetailsState();
}

class _AddContactDetailsState extends State<AddContactDetails> {

  TextEditingController place = TextEditingController();
  TextEditingController road = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final CollectionReference contact =
  FirebaseFirestore.instance.collection('contact');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("adding contactDetails"),
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
                child: Text(AppLocalizations.of(context)!.place),
              ),
              CustomTextForm(hinttext: "e.g : Brighton college", myController: place),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.streetName),
              ),
              CustomTextForm(hinttext: "e.g: Eastern Road",  myController: road),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.city),
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
              CustomButton
                (onPressed: () async {
                await contact.doc().set({
                  "place" : place.text,
                  "street name" : road.text,
                  "city" : city.text,
                  "post code" : postcode.text,
                  "email" : email.text,
                  "phone" : phone.text
                });
                Navigator.of(context).pushNamed("contactus");
                clearText();
              }, title: "Submit")
              )
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
