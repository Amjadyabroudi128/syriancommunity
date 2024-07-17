import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/HomePage/HomePage.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/features/widgets/editHomeTexts.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../components/Sizedbox.dart';
import '../../components/SubmitButton.dart';
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
                  edithomeText(name: name, widget: widget),
                  sizedBox(height: 20,),
                  padding(child: Text("post Details")),
                  sizedBox(height: 3,),
                  editDetails(details: details, widget: widget),
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
    bool isUnchangedOrEmpty = (name.text == widget.oldName && details.text == widget.oldDetail) ||
          name.text.isEmpty || details.text.isEmpty;
   String btnTitle = (widget.oldName == name.text && widget.oldDetail == details.text || name.text.isEmpty || details.text.isEmpty)
        ? "Updating"  : AppLocalizations.of(context)!.update;
   Color btnClr = (name.text == widget.oldName)
       && (details.text == widget.oldDetail) ? ColorManager.emptyLogin : ColorManager.submit;
    return CustomButton(
        onPressed: () async {
          if (isUnchangedOrEmpty) {
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
        title:  btnTitle,
        color: btnClr
    );
  }
  cancelButton () {
  return CustomButton(onPressed: (){
      Navigator.pop(context);
    }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,);
  }
}

