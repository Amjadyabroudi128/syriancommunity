import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMember extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  final String? oldUrl;

  const EditMember({Key? key, required this.DocID, required this.oldName, required this.oldDetail,  this.oldUrl,}) : super(key: key);

  @override
  State<EditMember> createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember> {
  late final TextEditingController name = TextEditingController()..addListener(() {
    setState(() {
    });
  });
 late final TextEditingController details = TextEditingController()..addListener(() {
   setState(() {
   });
 });
  bool? isUpdated;
  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetail;
    url.url = widget.oldUrl;
    isUpdated = isUpdated;
  }
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String edit = AppLocalizations.of(context)!.editDetails;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
    child: Scaffold(
      appBar: AppBar(
        title: Text(edit),
        leading: goBack(),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          child: padding(
            child: Form(
              key: Validate.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: url.url != null ? myImage(
                        onPressed: () async {
                          await url.pickImage();
                          setState(() {
                          });
                        },
                        src: url.url,
                        width: 210,
                        height: 210,
                        fit: BoxFit.cover
                      ) : SizedBox.shrink(),
                    ),
                  ),
                  padding(child: Text("Member name", style: TextStyles.font14green,)),
                  sizedBox(height: 3,),
                  CustomTextForm(
                      label: Text(AppLocalizations.of(context)!.name),
                   myController: name,
                      suffixIcon: IconButton(onPressed: name.clear, icon: myIcons.clear,),
                    validator: (name){
                      if(name == null || name == widget.oldName ) {
                        return AppLocalizations.of(context)!.editMember;
                      }
                      return null;
                    },

                  ),
                  sizedBox(height: 20,),
                  padding(child: Text("Member's Details", style: TextStyles.font14green,)),
                  CustomTextForm(
                      label: Text(AppLocalizations.of(context)!.details),
                      myController: details,
                      suffixIcon: IconButton(onPressed: details.clear, icon: myIcons.clear,),
                    validator: (name){
                      if(name == null || name == widget.oldDetail ) {
                        return AppLocalizations.of(context)!.editMemberDetails;
                      }
                      return null;
                    },
                  ),
                  sizedBox(height: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelButton(),
                      sizedBox(width: 16,),
                      editButton(),
                    ],
                  ),
                  sizedBox(height: 5,),
                  Center(child: imageButton()),
                ],
              ),
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
  cancelButton() {
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
  editButton() {
   return CustomButton(
        onPressed: () async {
          Validate.validating();
          if(name.text == widget.oldName && details.text == widget.oldDetail) {
            setState(() {
              isUpdated = false;
              showSnackBar(context, AppLocalizations.of(context)!.addThings);

            });
          } else {
            setState(() async {
              isUpdated = true;
              await dbColl.members.doc(widget.DocID).update(
                  {
                    "image" : url.url,
                    "name" : name.text,
                    "details" : details.text
                  }
              );
              showSnackBar(context, AppLocalizations.of(context)!.editedSuccessfully);
              Navigator.pop(context);
            });
          }
        },
        title:  AppLocalizations.of(context)!.update,
        color: (name.text == widget.oldName)
            && (details.text == widget.oldDetail) ? Colors.grey : ColorManager.submit);
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
