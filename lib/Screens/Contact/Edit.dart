import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/padding.dart';

import '../../components/Sizedbox.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/core/themes/colors.dart';
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              padding(child: Text(AppLocalizations.of(context)!.place)),
              sizedBox(height: 8,),
              CustomTextForm(hinttext: "e.g : Brighton college", myController: place,
                  suffixIcon: IconButton(onPressed: place.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.streetName)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: Eastern Road",  myController: road,
                  suffixIcon: IconButton(onPressed: road.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.city)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: Brighton", myController: city,
                  suffixIcon: IconButton(onPressed: city.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.postCode)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: BN2 OAL", myController: postcode,
                  suffixIcon: IconButton(onPressed: postcode.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.email)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.email, myController: email,
                  suffixIcon: IconButton(onPressed: email.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.phone),),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.phone, myController: phone,
                  suffixIcon: IconButton(onPressed: phone.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              sizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 updateButton(),
                  sizedBox(width: 10,),
                  CustomButton(onPressed: (){
                    Navigator.pop(context);
                  }, title: "Cancel", color: ColorManager.delete,)
                ],
              )

            ],
          ),
        ),
      ),
      )
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
  updateButton() {
    return CustomButton(onPressed: () async {
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
    }, title: AppLocalizations.of(context)!.update, color: ColorManager.submit,);
  }
}