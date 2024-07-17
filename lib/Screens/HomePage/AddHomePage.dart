import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/Screens/HomePage/HomePage.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/features/widgets/addHomeTexts.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../Api/Firebase_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../classes/validate state.dart';
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
  bool _showIcon = false;
  late final TextEditingController name = TextEditingController()..addListener(() {
    setState(() {
      name.text.isNotEmpty ? _showIcon = false : true;
    });
  });
 late final TextEditingController details = TextEditingController()..addListener(() {
    setState(() {
      details.text.isNotEmpty ? _showIcon = false : true;

    });
  });
  DateTime today = DateTime.now();
  late IconData errorIcon;
  void _checkTextField() {
    setState(() {
      _showIcon = name.text.isEmpty && details.text.isEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    details;
    name;
  }

  Future<void> _validateAndSubmit() async {
    if (Validate.formKey.currentState?.validate() ?? false)  {
      // If the form is valid, perform some action
      await dbColl.myHome.doc().set(
          {
            "name" : name.text,
            "details" : details.text,
            "time" :today,
          }
      );
      await FirebaseApi().initNotifications();
      await dbColl.notification;
      Navigator.push(context, HomePage.route());
      showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
      clearText();
      Validate.formKey.currentState!.reset();
    } else {
      _checkTextField();
    }
  }
  @override
  Widget build(BuildContext context) {
    String id = AppLocalizations.of(context)!.addDetails;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(id),
          leading: goBack(
            onPressed: () {
                Navigator.push(context, HomePage.route());
                setState(() {
                  Validate.formKey.currentState!.reset();
                });
            },
          )
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 10, right: 20),
              child: Form(
                key: Validate.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    padding(child: Text("post Name")),
                      sizedBox(height: 3,),
                    nameText(name: name, showIcon: _showIcon),
                    sizedBox(height: 10.h,),
                    padding(child: Text("post Details")),
                    sizedBox(height: 3.h,),
                    textDetails(details: details, showIcon: _showIcon),
                    sizedBox(height: 10.h,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           cancelButton(),
                           sizedBox(width: 15,),
                           addButton(),
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
 addButton() {
    Color btnClr = (name.text.isEmpty)
        && (details.text.isEmpty) ? ColorManager.emptyLogin : ColorManager.submit;
   return CustomButton(
       onPressed: _validateAndSubmit,
       title: AppLocalizations.of(context)!.submit,
       color: btnClr
   );
 }
}



