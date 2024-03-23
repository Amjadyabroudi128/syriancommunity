import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/themes/colors.dart';

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
        title: Text(AppLocalizations.of(context)!.addDetails),
        ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.addThings)),
              sizedBox(),
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
              CustomTextForm(hinttext: AppLocalizations.of(context)!.email, myController: email),
              padding(child: Text(AppLocalizations.of(context)!.phone),),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.phone, myController: phone),
              sizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: ()async {
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
                    },
                    title: AppLocalizations.of(context)!.submit, color: ColorManager.submit,
                  ),
                  sizedBox(width: 15,),
                  CustomButton(
                    onPressed: (){},
                    title: AppLocalizations.of(context)!.cancel,
                    color: ColorManager.delete,
                  )
                ],
              )
              // Center(child:
              // CustomButton
              //   (onPressed: () async {
              //   await contact.doc().set({
              //     "place" : place.text,
              //     "street name" : road.text,
              //     "city" : city.text,
              //     "post code" : postcode.text,
              //     "email" : email.text,
              //     "phone" : phone.text
              //   });
              //   Navigator.of(context).pushNamed("contactus");
              //   clearText();
              // }, title: AppLocalizations.of(context)!.submit, color: ColorManager.addEdit,)
              // )
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
