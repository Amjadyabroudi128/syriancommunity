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
import 'package:syrianadmin/core/themes/colors.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../classes/pickImage.dart' as url;
import '../../components/image.network.dart';
class EditCommunity extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetails;
  final String? oldUrl;
  const EditCommunity({Key? key, required this.DocID, required this.oldName, required this.oldDetails, this.oldUrl,}) : super(key: key);

  @override
  State<EditCommunity> createState() => _EditCommunityState();
}

class _EditCommunityState extends State<EditCommunity> {
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
    details.text = widget.oldDetails;
    url.url = widget.oldUrl;
    isUpdated = false;
  }
   bool? isUpdated;
  void dispose() {
    super.dispose();
    name;
    details;
    isUpdated;
    url.url;
  }
  @override
  Widget build(BuildContext context) {
    String editTitle = AppLocalizations.of(context)!.editDetails ;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(editTitle),
          leading: goBack(
            onPressed: (){
              Navigator.of(context).pushNamed("community");
            },
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Form(
              key: Validate.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async {
                      await url.pickImage();
                      setState(() {
                      });
                    },
                    child: Center(
                      child: url.url != null ?myImage(
                        src: url.url,
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                      ) : SizedBox.shrink(),
                    ),
                  ),
                  sizedBox(height: 3,),
                  padding(child: Text("Edit Name")),
                  CustomTextForm(
                    label: Text(AppLocalizations.of(context)!.name),
                      myController: name,
                      suffixIcon: IconButton(onPressed: name.clear, icon: myIcons.clear,),
                    validator: (value) {
                      if(value == null || name.text == widget.oldName) {
                        return "\u2757 ${AppLocalizations.of(context)!.addThings}";
                      }
                      return null;
                    },
                  ),
                  sizedBox(height: 5.h,),
                  padding(child: Text("Edit Details ")),
                  CustomTextForm(
                      label: Text(AppLocalizations.of(context)!.details),
                      myController: details,
                      suffixIcon: IconButton(onPressed: details.clear, icon: myIcons.clear,),
                    validator: (value) {
                      if(value == null || details.text == widget.oldDetails) {
                        return "\u2757 ${AppLocalizations.of(context)!.addThings}";
                      }
                      return null;
                    },
                  ),
                  sizedBox(height: 6.h,),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  imageButton () {
    return CustomButton(
      title: AppLocalizations.of(context)!.image,
      onPressed: () async {
        await url.pickImage();
        setState(() {
        });
      },
      color: add,
    );
  }
  cancelButton() {
    return CustomButton(
      onPressed: (){
        Navigator.pop(context);
      },
      title: AppLocalizations.of(context)!.cancel,
      color: cancelClr,
    );
  }
  submitButton () {
    bool isUnchangedOrEmpty = (name.text == widget.oldName && details.text == widget.oldDetails) ||
        name.text.isEmpty || details.text.isEmpty;
    Color buttonColor = (widget.oldName == name.text && widget.oldDetails == details.text ||
        name.text.isEmpty || details.text.isEmpty)  ? Colors.grey : ColorManager.submit;
    String btnTitle = (widget.oldName == name.text && widget.oldDetails == details.text || name.text.isEmpty || details.text.isEmpty)
        ? "Updating"  : AppLocalizations.of(context)!.update;
    return CustomButton(
      onPressed: () async {
      if(isUnchangedOrEmpty) {
        Validate.validating();
        showSnackBar(context, AppLocalizations.of(context)!.update, duration: Duration(seconds: 2));
        setState(() {
          isUpdated = false;
        });
      } else {
        await dbColl.community.doc(widget.DocID).update({
          "name" : name.text,
          "details" : details.text,
          "image" : url.url
        });
        Navigator.pop(context);
        showSnackBar(context, AppLocalizations.of(context)!.editedSuccessfully);
      }
      setState(() {
        isUpdated = true;
      });
    }, title:  btnTitle,
      color:  buttonColor
    );
  }
}


