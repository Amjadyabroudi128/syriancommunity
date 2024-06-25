import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
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
   static final formKey = GlobalKey<FormState>();
  final CollectionReference members =
      FirebaseFirestore.instance.collection('members');
  @override
  Widget build(BuildContext context) {

    String addThings = AppLocalizations.of(context)!.addThings;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(addThings),
            leading: goBack()
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
                      height: 6,
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
                            return AppLocalizations.of(context)!.addName;
                          }
                          return null;
                      },
                    ),
                    sizedBox(
                      height: 12,
                    ),
                    padding(
                        child: Text(
                      AppLocalizations.of(context)!.details,
                      style: TextStyles.font14green,
                    )),
                    sizedBox(
                      height: 6,
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
                          return AppLocalizations.of(context)!.memberDetails;
                        }
                        return null;
                      },
                    ),
                    sizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cancelButton(),
                        sizedBox(
                          width: 13,
                        ),
                        addButon()
                      ],
                    ),
                    sizedBox(
                      height: 6,
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
    return CustomButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      title: AppLocalizations.of(context)!.cancel,
      color: ColorManager.delete,
    );
  }

  imageButton() {
    return CustomButton(
      title: AppLocalizations.of(context)!.image,
      onPressed: () async {
        await url.pickImage();
        setState(() {});
      },
      color: ColorManager.addEdit,
    );
  }
  addButon () {
   return CustomButton(
        onPressed: () async {
          Validate.validating();
          if (name.text.isEmpty || details.text.isEmpty) {
            showSnackBar(context, AppLocalizations.of(context)!.addThings);
          } else if (url.url == null) {
            await members
                .doc()
                .set({"name": name.text, "details": details.text});
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.addedSuccessfully),
            ));
            Navigator.of(context).pop();
            clearText();
          } else {
            await members.doc().set({
              "name": name.text,
              "details": details.text,
              "image": url.url,
            });
            showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
            Navigator.of(context).pushNamed("ourteam");
            clearText();
          }
        },
        title: AppLocalizations.of(context)!.submit,
        color: (name.text.isEmpty) && (details.text.isEmpty)
            ? Colors.grey
            : ColorManager.submit);
  }
  goBack () {
    return IconButton(
        onPressed: (){
          Navigator.of(context).pushNamed("ourteam");
          formKey.currentState!.reset();

        },
        icon: myIcons.goBack);
  }
}
