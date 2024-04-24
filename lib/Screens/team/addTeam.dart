import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();

  final CollectionReference members =
  FirebaseFirestore.instance.collection('members');
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addThings),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding(child: Text(AppLocalizations.of(context)!.name, style: TextStyles.font14green,)),
                CustomTextForm(hinttext: "name", myController: name,
                    suffixIcon: IconButton(onPressed: name.clear, icon: Icon(Icons.clear), color: Colors.black,)
                ),
                sizedBox(height: 20,),
                padding(child: Text(AppLocalizations.of(context)!.details, style: TextStyles.font14green,)),
                CustomTextForm(maxLines: null, hinttext: "details", myController: details,
                  suffixIcon: IconButton(onPressed: details.clear, icon: Icon(Icons.clear), color: Colors.black,)
                ),
                sizedBox(height: 12,),
                Center(
                  child: CustomButton(
                    title: AppLocalizations.of(context)!.image,
                    onPressed: () async {
                    await url.pickImage();
                      setState(() {
                      });
                    },
                    color: ColorManager.addEdit,
                  ),
                ),
                sizedBox(height: 15,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CustomButton(
                         onPressed: ()async {
                           if (url.url == null) {
                             await members.doc().set(
                               {
                               "name": name.text,
                               "details": details.text
                               }
                             );
                             Navigator.of(context).pop();
                             clearText();
                           } else {
                                 await members.doc().set(
                                     {
                                       "name" : name.text,
                                       "details" : details.text,
                                       "image" : url.url,
                                     }
                                 );
                                 Navigator.of(context).pushNamed("ourteam");
                                 clearText();
                           }
                         },

                          title: AppLocalizations.of(context)!.submit, color: ColorManager.submit,),
                       sizedBox(width: 15,),
                       CustomButton(onPressed: (){
                         Navigator.of(context).pop();
                       }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,)
                     ],
                   ),

              ],
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
}
