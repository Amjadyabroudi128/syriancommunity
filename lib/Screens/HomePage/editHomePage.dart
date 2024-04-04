import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/padding.dart';
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
                CustomTextForm(hinttext: "name", myController: name,
                    suffixIcon: IconButton(onPressed: name.clear, icon: Icon(Icons.clear), color: Colors.black,)

                ),
                sizedBox(height: 20,),
                padding(child: Text(AppLocalizations.of(context)!.details)),
                CustomTextForm(hinttext: "details", myController: details, maxLines: 6,
                    suffixIcon: IconButton(onPressed: details.clear, icon: Icon(Icons.clear), color: Colors.black,)
                ),
                sizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                            onPressed: () async {
                              await home.doc(widget.DocID).update(
                                {
                                  "name" : name.text,
                                  "details" : details.text,
                                }
                              );
                              Navigator.of(context).pushNamed("homepage");
                            },
                            title: AppLocalizations.of(context)!.update, color: ColorManager.submit,),
                    sizedBox(width: 10,),
                    CustomButton(onPressed: (){
                      Navigator.pop(context);
                    }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,)
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
