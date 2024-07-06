import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/HomePage/HomePage.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../components/Sizedbox.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditHome extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  const EditHome({Key? key, required this.DocID, required this.oldName, required this.oldDetail}) : super(key: key);

  @override
  State<EditHome> createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  late final TextEditingController name = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late final TextEditingController details = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetail;
  }
  @override
  void dispose() {
    super.dispose();
    name;
    details;
  }
  @override
  Widget build(BuildContext context) {
    String editTitle = AppLocalizations.of(context)!.editDetails ;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),

    child: Scaffold(
      appBar: AppBar(
        title: Text(editTitle),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 60, left: 10, right: 20),
            child: Form(
              key: Validate.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(child: Text("post Name")),
                  sizedBox(height: 3,),
                  CustomTextForm(
                      label: Text(AppLocalizations.of(context)!.name), myController: name,
                      suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear,),
                    validator: (value) {
                      if(value == null || name.text == widget.oldName) {
                        return AppLocalizations.of(context)!.addThings;
                      }
                      return null;
                    },
                  ),
                  sizedBox(height: 20,),
                  padding(child: Text("post Details")),
                  sizedBox(height: 3,),
                  CustomTextForm(
                    label: Text(AppLocalizations.of(context)!.details),
                      myController: details,
                      suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: myIcons.clear ),
                    validator: (value) {
                      if(value == null || details.text == widget.oldDetail) {
                        return AppLocalizations.of(context)!.editDetails;
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
                      updateButton(),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  updateButton () {

    return CustomButton(
        onPressed: () async {
          if (name.text == widget.oldName && details.text == widget.oldDetail) {
            Validate.validating();
          }
          else {
            await dbColl.myHome.doc(widget.DocID).update({
              "name": name.text,
              "details": details.text,

            });
            Navigator.push(context, HomePage.route());
            showSnackBar(context, AppLocalizations.of(context)!.editedSuccessfully);
          }
        },
        title: AppLocalizations.of(context)!.update,
        color: (name.text == widget.oldName)
         && (details.text == widget.oldDetail) ? Colors.grey : ColorManager.submit );
  }
  cancelButton () {
  return CustomButton(onPressed: (){
      Navigator.pop(context);
    }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,);
  }
}
