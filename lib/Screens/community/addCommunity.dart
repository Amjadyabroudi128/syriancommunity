
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
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

  final CollectionReference community =
  FirebaseFirestore.instance.collection('Community');
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(),
              padding(child: Text("Event Name"),),
              CustomTextForm(label: Text(AppLocalizations.of(context)!.name), myController: name,
                  suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear)
              ),
              sizedBox(),
              padding(
                child: Text("what we do"),
              ),
              CustomTextForm(label: Text(AppLocalizations.of(context)!.details), myController: details,
                  suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: myIcons.clear)
              ),
              sizedBox(height: 10,),
              Center(
                child: imageButton(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cancelButton(),
                  sizedBox(width: 10,),
                  submitButton(),
                ],
              ),

            ],
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
        ScaffoldMessenger.of(context).showSnackBar
          ( SnackBar(content: Text(AppLocalizations.of(context)!.addThings), duration: Duration(seconds: 1),));
      } else if (url.url == null) {
            await   community.doc().set({
              "name" : name.text,
              "details" : details.text
            });
            Navigator.pushReplacementNamed(context, 'community');
      }  else {
            await community.doc().set({
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
