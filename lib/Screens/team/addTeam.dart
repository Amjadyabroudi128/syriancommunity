import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/constants.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/themes/fontSize.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  late final TextEditingController name = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  late final TextEditingController details = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  @override
  Widget build(BuildContext context) {

    String addThings = AppLocalizations.of(context)!.addThings;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(addThings),
            leading: goBack(
              onPressed: (){
                Navigator.of(context).pushNamed("ourteam");
                Validate.formKey.currentState!.reset();
              },
            )
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: Validate.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    padding(
                        child: Text(
                      AppLocalizations.of(context)!.name,
                      style: TextStyles.font14green,
                    )),
                    sizedBox(
                      height: 6.h,
                    ),
                    CustomTextForm(
                        label: Text("Member's name "),
                        myController: name,
                        suffixIcon: name.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: name.clear,
                                icon: myIcons.clear,
                              ),
                      validator: (value){
                          if(value == null || name.text.isEmpty) {
                            return "\u2757 ${AppLocalizations.of(context)!.addName}";
                          }
                          return null;
                      },
                    ),
                    sizedBox(
                      height: 7.h,
                    ),
                    padding(
                        child: Text(
                      AppLocalizations.of(context)!.details,
                      style: TextStyles.font14green,
                    )),
                    sizedBox(
                      height: 6.h,
                    ),
                    CustomTextForm(
                        label: Text("Member's Details"),
                        myController: details,
                        suffixIcon: details.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: details.clear,
                                icon: myIcons.clear,
                              ),
                      validator: (value){
                        if(value == null || details.text.isEmpty) {
                          return "\u2757 ${AppLocalizations.of(context)!.memberDetails}";
                        }
                        return null;
                      },
                    ),
                    sizedBox(height: 7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cancelButton(),
                        sizedBox(
                          width: 13.w,
                        ),
                        addButton()
                      ],
                    ),
                    sizedBox(
                      height: 6.h,
                    ),
                    Center(child: imageButton(),),


                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void clearText() {
    name.clear();
    details.clear();
  }

  cancelButton() {
    String title = AppLocalizations.of(context)!.cancel;
    return CustomButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      title: title,
      color: cancelClr,
    );
  }

  imageButton() {
    String title = AppLocalizations.of(context)!.image;
    return CustomButton(
      title: title,
      onPressed: () async {
        await url.pickImage();
        setState(() {});
      },
      color: add,
    );
  }
  addButton () {
    bool isEmpty = (name.text.isEmpty || details.text.isEmpty);
    Color? btnColor = (name.text.isEmpty) || (details.text.isEmpty) ? empty: submit;
    String btnTitle = AppLocalizations.of(context)!.submit;
    return CustomButton(
        onPressed: () async {
          if (isEmpty) {
            Validate.validating();
          } else if (url.url == null) {
            await dbColl.members
                .doc()
                .set({"name": name.text, "details": details.text});
            showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
            Navigator.of(context).pop();
            clearText();
          } else {
            await dbColl.members.doc().set({
              "name": name.text,
              "details": details.text,
              "image": url.url,
            });
            showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
            Navigator.of(context).pushNamed("ourteam");
            clearText();
          }
        },
        title: btnTitle,
        color: btnColor
    );
  }
}
