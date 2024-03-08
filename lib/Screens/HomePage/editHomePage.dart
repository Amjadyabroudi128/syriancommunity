import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/padding.dart';

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
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetail;
  }
  @override
  Widget build(BuildContext context) {
    final CollectionReference home =
    FirebaseFirestore.instance.collection('home');
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editDetails),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding(child: Text(AppLocalizations.of(context)!.name)),
                CustomTextForm(hinttext: "name", myController: name),
                sizedBox(height: 20,),
                padding(child: Text(AppLocalizations.of(context)!.details)),
                CustomTextForm(hinttext: "details", myController: details, maxLines: 6,),
                sizedBox(),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                        await home.doc(widget.DocID).update(
                          {
                            "name" : name.text,
                            "details" : details.text,
                            // i can add the time but then the edited post will be first 
                          }
                        );
                        Navigator.of(context).pushNamed("homepage");
                      },
                      title: AppLocalizations.of(context)!.update),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
