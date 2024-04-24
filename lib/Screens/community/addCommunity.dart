
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();

  final CollectionReference community =
  FirebaseFirestore.instance.collection('Community');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
    child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDetails),
      ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.name),),
              CustomTextForm(hinttext: "BreakFast Club", myController: name,
                  suffixIcon: IconButton(onPressed: name.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              sizedBox(),
              padding(
                child: Text(AppLocalizations.of(context)!.details),
              ),
              CustomTextForm(hinttext: "What we do ", myController: details, maxLines: 6,
                  suffixIcon: IconButton(onPressed: details.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              sizedBox(height: 10,),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(onPressed: () async {
                      if(url.url == null) {
                     await   community.doc().set({
                          "name" : name.text,
                          "details" : details.text
                        });
                     Navigator.pushReplacementNamed(context, 'community');
                      } else {
                       await community.doc().set({
                          "name" : name.text,
                          "details" : details.text,
                          "image" : url.url,
                        });
                       Navigator.pushReplacementNamed(context,'community');
                      }
                    }
                    , title: AppLocalizations.of(context)!.submit, color: ColorManager.submit,
                    ),
                  sizedBox(width: 10,),
                  CustomButton(onPressed: (){
                    Navigator.pop(context);
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
}
