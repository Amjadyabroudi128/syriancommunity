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
  ScrollController _scrollController = ScrollController();

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final CollectionReference home =
    FirebaseFirestore.instance.collection('home');
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
                padding(child: Text(AppLocalizations.of(context)!.name)),
                  CustomTextForm(
                      hinttext: "name",
                      myController: name),
                sizedBox(),
                padding(child: Text(AppLocalizations.of(context)!.details,)),
                CustomTextForm(
                    hinttext: "details",
                    myController: details,
                  maxLines: 6,
                ),
                sizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CustomButton(
                          onPressed: () async {
                           await home.doc().set(
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
                          title: AppLocalizations.of(context)!.submit, color: ColorManager.submit,),
                       sizedBox(width: 15,),
                       CustomButton(onPressed: (){
                         Navigator.pop(context);
                       }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,)
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

}
