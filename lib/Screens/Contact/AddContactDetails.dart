import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/constants.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';

import '../../components/snackBar.dart';
class AddContactDetails extends StatefulWidget {
  const AddContactDetails({Key? key}) : super(key: key);

  @override
  State<AddContactDetails> createState() => _AddContactDetailsState();
}

class _AddContactDetailsState extends State<AddContactDetails> {

  late final TextEditingController place = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController road = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController city = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController postcode = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController email = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController phone = TextEditingController()..addListener(() {
    setState(() {
    });
  });



  @override
  Widget build(BuildContext context) {
    Text contact = Text(AppLocalizations.of(context)!.addDetails);
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
    child: Scaffold(
        appBar: AppBar(
          title: contact,
          leading: goBack(
            onPressed: () {
              Navigator.of(context).pushNamed("contactus");
            },
          ),
        ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // sizedBox(height: 10,),
              padding(child: Text("e.g Brighton College ")),
              sizedBox(height: 2,),
              CustomTextForm(label: Text(AppLocalizations.of(context)!.place), myController: place,
                  suffixIcon: place.text.isEmpty ? null :  IconButton(onPressed: place.clear, icon: myIcons.clear,)
              ),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.streetName)),
              sizedBox(height: 2,),
              CustomTextForm(hinttext: "e.g: Eastern Road",  myController: road,
                  suffixIcon: road.text.isEmpty? null : IconButton(onPressed: road.clear, icon: myIcons.clear)
              ),
              padding(child: Text(AppLocalizations.of(context)!.city)),
              sizedBox(height: 2,),
              CustomTextForm(hinttext: "e.g: Brighton", myController: city,
                  suffixIcon: city.text.isEmpty ? null : IconButton(onPressed: city.clear, icon: myIcons.clear)
              ),
              padding(child: Text(AppLocalizations.of(context)!.postCode)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: BN2 OAL", myController: postcode,
                  suffixIcon: postcode.text.isEmpty ? null : IconButton(onPressed: postcode.clear, icon: myIcons.clear)
              ),
              padding(child: Text(AppLocalizations.of(context)!.email)),
              sizedBox(height: 2,),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.email, myController: email,
                  suffixIcon: email.text.isEmpty ? null : IconButton(onPressed: email.clear, icon: myIcons.clear)
              ),
              padding(child: Text(AppLocalizations.of(context)!.phone),),
              sizedBox(height: 2,),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.phone, myController: phone,
                  suffixIcon: phone.text.isEmpty ? null :  IconButton(onPressed: phone.clear, icon: myIcons.clear)
              ),
              sizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cancelButton(),
                  sizedBox(width: 15,),
                  submitButton(),

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
  }
  cancelButton() {
    String cnclTitle = AppLocalizations.of(context)!.cancel;
    return CustomButton(
      onPressed: (){
        Navigator.pop(context);
      },
      title: cnclTitle,
      color: cancelClr,
    );
  }
  submitButton() {
    String title = AppLocalizations.of(context)!.submit;
    Color? btnClr = (place.text.isEmpty ) || (road.text.isEmpty)
        || (city.text.isEmpty) ||(postcode.text.isEmpty)
        ||(email.text.isEmpty) || (phone.text.isEmpty) ? add : submit ;
    return CustomButton(
      onPressed: () async{
        if (place.text.isEmpty || road.text.isEmpty
        || city.text.isEmpty || postcode.text.isEmpty
        || email.text.isEmpty || phone.text.isEmpty) {
          showSnackBar(context, AppLocalizations.of(context)!.addThings);
        } else {
          await dbColl.contact.doc().set(
            {
                  "place" : place.text,
                  "street name" : road.text,
                  "city" : city.text,
                  "post code" : postcode.text,
                  "email" : email.text,
                  "phone" : phone.text
            }
          );
          showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);

          Navigator.of(context).pushNamed("contactus");
        }
      },
      title: title,
      color: btnClr,
    );
  }

}
