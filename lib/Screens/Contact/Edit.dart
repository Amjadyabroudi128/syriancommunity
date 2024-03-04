import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/padding.dart';

import '../../components/Sizedbox.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditDetails extends StatefulWidget {
  final String DocID;
  final String oldPlace;
  final String oldRoad;
  final String oldCity;
  final String oldEmail;
  final String oldPHone;
  final String oldPostCode;

  const EditDetails({Key? key, required this.DocID, required this.oldPlace, required this.oldRoad, required this.oldCity, required this.oldEmail, required this.oldPHone, required this.oldPostCode}) : super(key: key);

  @override
  State<EditDetails> createState() => _AddContactDetailsState();
}

class _AddContactDetailsState extends State<EditDetails> {

  TextEditingController place = TextEditingController();
  TextEditingController road = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    super.initState();
    place.text = widget.oldPlace;
    road.text = widget.oldRoad;
    city.text = widget.oldCity;
    postcode.text = widget.oldPostCode;
    phone.text = widget.oldPHone;
    email.text = widget.oldEmail;
  }
  final CollectionReference contact =
  FirebaseFirestore.instance.collection('contact');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.editDetails),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(AppLocalizations.of(context)!.place),
              // ),
              padding(child: Text(AppLocalizations.of(context)!.place)),
              CustomTextForm(hinttext: "e.g : Brighton college", myController: place),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.streetName)),
              CustomTextForm(hinttext: "e.g: Eastern Road",  myController: road),
              padding(child: Text(AppLocalizations.of(context)!.city)),
              CustomTextForm(hinttext: "e.g: Brighton", myController: city),
              padding(child: Text(AppLocalizations.of(context)!.postCode)),
              CustomTextForm(hinttext: "e.g: BN2 OAL", myController: postcode),
              padding(child: Text(AppLocalizations.of(context)!.email)),
              CustomTextForm(hinttext: "email", myController: email),
              padding(child: Text(AppLocalizations.of(context)!.phone)),
              CustomTextForm(hinttext: "phone", myController: phone),
              sizedBox(),
              Center(child:
              CustomButton
                (onPressed: () async {
                await contact.doc(widget.DocID).update({
                  "place" : place.text,
                  "street name" : road.text,
                  "city" : city.text,
                  "post code" : postcode.text,
                  "email" : email.text,
                  "phone" : phone.text
                });
                Navigator.pop(context);
                clearText();
              }, title: AppLocalizations.of(context)!.update)
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
    phone.clear();
  }
}