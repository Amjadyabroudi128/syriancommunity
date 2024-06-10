import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/HomePage/HomePage.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../Api/Firebase_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/Sizedbox.dart';

class AddInfo extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => AddInfo(),
  );
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
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String id = AppLocalizations.of(context)!.addDetails;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(id),
          leading: IconButton(onPressed: (){
            Navigator.push(context, HomePage.route());
            setState(() {
              formKey.currentState!.reset();
            });
          },
              icon: myIcons.goBack
          ),
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 60, left: 10, right: 20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    padding(child: Text("post Name")),
                      sizedBox(height: 3,),
                      CustomTextForm(
                          label: Text(AppLocalizations.of(context)!.name),
                          myController: name,
                          suffixIcon: name.text.isEmpty ? null :
                          IconButton(onPressed: name.clear, icon: myIcons.clear,),
                        validator: (value) {
                          if(value == null || name.text.isEmpty) {
                           return AppLocalizations.of(context)!.addThings;
                          }
                          return null;
                        },
                      ),
                    sizedBox(height: 10,),
                    padding(child: Text("post Details")),
                    sizedBox(height: 3,),
                    CustomTextForm(
                        label: Text(AppLocalizations.of(context)!.details),
                        myController: details,
                        suffixIcon: details.text.isEmpty ? null :
                        IconButton(onPressed: details.clear, icon: myIcons.clear,),
                      validator: (value) {
                          if(value == null || details.text.isEmpty) {
                          return AppLocalizations.of(context)!.addDetails;
                          }
                          return null;
                      },
                    ),
                    sizedBox(height: 10,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           cancelButton(),
                           sizedBox(width: 15,),
                           CustomButton(
                               onPressed: () async {
                                 formKey.currentState!.validate();
                                 if ( name.text.isEmpty || details.text.isEmpty ) {
                                   ScaffoldMessenger.of(context).showSnackBar
                                     ( SnackBar(content: Text(AppLocalizations.of(context)!.addThings),));
                                 } else {
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
                                   Navigator.push(context, HomePage.route());
                                   ScaffoldMessenger.of(context).showSnackBar
                                     ( SnackBar(content: Text("${AppLocalizations.of(context)!.addedSuccessfully}",)));
                                 }
                               },
                               title: AppLocalizations.of(context)!.submit,
                               color: (name.text.isEmpty)
                                   && (details.text.isEmpty) ? Colors.grey : ColorManager.submit
                           ),
                         ],
                       ),

                  ],
                ),
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
 // submitButton () {
 //    return ;
 // }
}
