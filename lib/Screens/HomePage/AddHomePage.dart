import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/themes/colors.dart';
import '../../Api/Firebase_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/Sizedbox.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDetails),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text(AppLocalizations.of(context)!.name),
                ),
                  CustomTextForm(
                      hinttext: "name",
                      myController: name),
                sizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text(AppLocalizations.of(context)!.details),
                ),
                CustomTextForm(
                    hinttext: "details",
                    myController: details,
                  maxLines: 6,
                ),
                sizedBox(),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                       await FirebaseFirestore.instance.collection("home").doc().set(
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
                      },
                      title: AppLocalizations.of(context)!.submit, color: ColorManager.addEdit,),
                )
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

}
