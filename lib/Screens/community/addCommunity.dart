import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        title: Text(addDetails),
      ),
      body: padding(
        child: SingleChildScrollView(
          child: Form(
            key: Validate.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(),
                padding(child: Text("Event Name"),),
                CustomTextForm(label: Text(AppLocalizations.of(context)!.name), myController: name,
                    suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear),
                  validator: (value) {
                    if(value == null || name.text.isEmpty) {
                      return AppLocalizations.of(context)!.addThings;
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
                      return AppLocalizations.of(context)!.addThings;
                    }
                    return null;
                  },
                ),
                sizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(),
                    sizedBox(width: 10,),
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
    return CustomButton(onPressed: (){
      Navigator.pop(context);
    }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,);
  }
  imageButton () {
    return CustomButton(
      title: AppLocalizations.of(context)!.image,
      onPressed: () async {
        await url.pickImage();
        setState(() {
        });
      },
      color: ColorManager.addEdit,
    );
  }
  submitButton() {
    return CustomButton(onPressed: () async {
      if ( name.text.isEmpty || details.text.isEmpty ) {
        Validate.validating();
        showSnackBar(context, AppLocalizations.of(context)!.addThings);
      } else if (url.url == null) {
            await   dbColl.community.doc().set({
              "name" : name.text,
              "details" : details.text
            });
            Navigator.pushReplacementNamed(context, 'community');
      }  else {
            await dbColl.community.doc().set({
              "name" : name.text,
              "details" : details.text,
              "image" : url.url,
            });
            Navigator.pushReplacementNamed(context,'community');
          }
    }
        , title: AppLocalizations.of(context)!.submit,
        color: (name.text.isEmpty)
            || (details.text.isEmpty) ? Colors.grey : ColorManager.submit
    );
  }
}
