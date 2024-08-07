import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Contact/ContactUS.dart';
import 'package:syrianadmin/components/constants.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/components/icons.dart';
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
        leading: goBack(
          onPressed: (){
            Navigator.push(context, ContactUs.route());
          },
        ),
        title: Text(AppLocalizations.of(context)!.editDetails),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding(child: Text(AppLocalizations.of(context)!.place)),
                sizedBox(height: 8,),
                CustomTextForm( myController: place,
                    suffixIcon: IconButton(onPressed: place.clear, icon: myIcons.clear)
                ),
                sizedBox(),
                padding(child: Text(AppLocalizations.of(context)!.streetName)),
                sizedBox(height: 7,),
                CustomTextForm( myController: road,
                    suffixIcon: IconButton(onPressed: road.clear, icon: myIcons.clear )
                ),
                padding(child: Text(AppLocalizations.of(context)!.city)),
                sizedBox(height: 7,),
                CustomTextForm( myController: city,
                    suffixIcon: IconButton(onPressed: city.clear, icon: myIcons.clear )
                ),
                padding(child: Text(AppLocalizations.of(context)!.postCode)),
                sizedBox(height: 7,),
                CustomTextForm(myController: postcode,
                    suffixIcon: IconButton(onPressed: postcode.clear, icon: myIcons.clear)
                ),
                padding(child: Text(AppLocalizations.of(context)!.email)),
                sizedBox(height: 7,),
                CustomTextForm( myController: email,
                    suffixIcon: IconButton(onPressed: email.clear, icon: myIcons.clear)
                ),
                padding(child: Text(AppLocalizations.of(context)!.phone),),
                sizedBox(height: 7,),
                CustomTextForm( myController: phone,
                    suffixIcon: IconButton(onPressed: phone.clear, icon: myIcons.clear)
                ),
                sizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(),
                    sizedBox(width: 10,),
                    updateButton(),
                  ],
                )

              ],
            ),
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
  updateButton() {
    return CustomButton(
      onPressed: () async {
        if (place.text == widget.oldPlace && road.text == widget.oldRoad
            && city.text == widget.oldCity && postcode.text == widget.oldPostCode
            && email.text == widget.oldEmail && phone.text == widget.oldPHone) {
          ScaffoldMessenger.of(context).showSnackBar
            (SnackBar(content: Text(AppLocalizations.of(context)!.addThings),));
        }
        else {
          await contact.doc(widget.DocID).update({
            "place": place.text,
            "street name": road.text,
            "city": city.text,
            "post code": postcode.text,
            "email": email.text,
            "phone": phone.text,

          });
          Navigator.of(context).pushNamed("contactus");
          clearText();
        }

    }, title: AppLocalizations.of(context)!.update, color: ColorManager.submit,);
  }
  cancelButton () {
   return CustomButton(onPressed: (){
      Navigator.pop(context);
    }, title: "Cancel", color: cancelClr);
  }
}