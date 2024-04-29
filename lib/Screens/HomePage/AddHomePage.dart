import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../Api/Firebase_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/Sizedbox.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  late final TextEditingController name = TextEditingController()..addListener(() {
    setState(() {
    });
  });
 late final TextEditingController details = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addDetails),
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 60, left: 10, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(child: Text(AppLocalizations.of(context)!.name)),
                    CustomTextForm(
                        hinttext: "name",
                        myController: name,
                        suffixIcon: name.text.isEmpty ? null :
                        IconButton(onPressed: name.clear, icon: Icon(Icons.clear), color: Colors.black,)

                    ),
                  sizedBox(),
                  padding(child: Text(AppLocalizations.of(context)!.details,)),
                  CustomTextForm(
                      hinttext: "details",
                      myController: details,
                    maxLines: 6,
                      suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: Icon(Icons.clear), color: Colors.black,)

                  ),
                  sizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         cancelButton(),
                         sizedBox(width: 15,),
                         submitButton(),
                       ],
                     ),

                ],
              ),
            ),
          ),

      ),
    );
  }
  void clearText() {
    name.clear();
    details.clear();
  }
 cancelButton () {
    return CustomButton(onPressed: (){
      Navigator.pop(context);
    }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,);
 }
 submitButton () {
    return CustomButton(
        onPressed: () async {
          if ( name.text.isEmpty || details.text.isEmpty ) {
            ScaffoldMessenger.of(context).showSnackBar
              ( SnackBar(content: Text(AppLocalizations.of(context)!.addThings),));
          } else {
            FirebaseFirestore.instance.collection("home").doc().set(
                {
                  "name" : name.text,
                  "details" : details.text,
                  "time" :today,
                }
            );
            clearText();
            await FirebaseApi().initNotifications();
            await FirebaseMessaging.instance.subscribeToTopic("topic");
            Navigator.of(context).pushNamed("homepage");
            ScaffoldMessenger.of(context).showSnackBar
              ( SnackBar(content: Text("${AppLocalizations.of(context)!.addedSuccessfully}",)));
          }
        },
        title: AppLocalizations.of(context)!.submit,
        color: (name.text.isEmpty)
            || (details.text.isEmpty) ? Colors.grey : ColorManager.submit
    );
 }
}
