import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/constants.dart';
class addCommunity extends StatefulWidget {
  const addCommunity({Key? key}) : super(key: key);

  @override
  State<addCommunity> createState() => _addCommunityState();
}

class _addCommunityState extends State<addCommunity> {
  late final TextEditingController name = TextEditingController()..addListener(() {
    setState(() {
    });
  });
 late final TextEditingController details = TextEditingController()..addListener(() {
   setState(() {
   });
 });


  @override
  Widget build(BuildContext context) {
    String addDetails = AppLocalizations.of(context)!.addDetails;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
    child: Scaffold(
      appBar: AppBar(
        leading: goBack(
          onPressed: (){
            Navigator.of(context).pushNamed("community");
          },
        ),
        title: Text(addDetails),
      ),
      body: padding(
        child: SingleChildScrollView(
          child: Form(
            key: Validate.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(),
                padding(child: Text("Event Name"),),
                CustomTextForm(label: Text(AppLocalizations.of(context)!.name), myController: name,
                    suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear),
                  validator: (value) {
                    if(value == null || name.text.isEmpty) {
                      return "\u2757 ${AppLocalizations.of(context)!.addThings}";
                    }
                    return null;
                  },
                ),
                sizedBox(height: 3.h,),
                padding(
                  child: Text("what we do"),
                ),
                CustomTextForm(label: Text(AppLocalizations.of(context)!.details), myController: details,
                    suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: myIcons.clear),
                  validator: (value) {
                    if(value == null || details.text.isEmpty) {
                      return "\u2757 ${AppLocalizations.of(context)!.addThings}";
                    }
                    return null;
                  },
                ),
                sizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(),
                    sizedBox(width: 10.w,),
                    submitButton(),
                  ],
                ),
                Center(
                  child: imageButton(),
                ),

              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
  cancelButton () {
    String title = AppLocalizations.of(context)!.cancel;
    return CustomButton(onPressed: (){
      Navigator.pop(context);
    }, title: title, color: cancel);
  }
  imageButton () {
    String title = AppLocalizations.of(context)!.image;
    return CustomButton(
      title: title,
      onPressed: () async {
        await url.pickImage();
        setState(() {
        });
      },
      color: add,
    );
  }
  submitButton() {
    bool isEmpty = (name.text.isEmpty || details.text.isEmpty);
    Color btnColor = (name.text.isEmpty)
        || (details.text.isEmpty) ? ColorManager.emptyLogin : ColorManager.submit;
    String btnTitle = AppLocalizations.of(context)!.submit;
    return CustomButton(onPressed: () async {
      if (isEmpty) {
        Validate.validating();
        showSnackBar(context, AppLocalizations.of(context)!.addThings);
      } else if (url.url == null) {
        await dbColl.community.doc().set({
          "name": name.text,
          "details": details.text
        });
        showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
        Navigator.pushReplacementNamed(context, 'community');
      } else {
        await dbColl.community.doc().set({
          "name": name.text,
          "details": details.text,
          "image": url.url,
        });
        showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
        Navigator.pushReplacementNamed(context, 'community');
      }
    }
        , title: btnTitle,
        color: btnColor
    );
  }
}
