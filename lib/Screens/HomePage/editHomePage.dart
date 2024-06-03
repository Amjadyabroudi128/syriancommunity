import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/HomePage/HomePage.dart';
import 'package:syrianadmin/components/icons.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding(child: Text("post Name")),
                CustomTextForm(
                    label: Text(AppLocalizations.of(context)!.name), myController: name,
                    suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear,)

                ),
                sizedBox(height: 20,),
                padding(child: Text(AppLocalizations.of(context)!.details)),
                CustomTextForm(hinttext: "info details", myController: details, maxLines: 6,
                    suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: myIcons.clear )                ),
                sizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(onPressed: (){
                      Navigator.pop(context);
                    }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,),
                    sizedBox(width: 10,),
                    updateButton(),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  updateButton () {
    final CollectionReference home =
    FirebaseFirestore.instance.collection('home');
    return CustomButton(
        onPressed: () async {
          if (name.text == widget.oldName && details.text == widget.oldDetail) {
            ScaffoldMessenger.of(context).showSnackBar
              (SnackBar(content: Text(
              "${AppLocalizations.of(context)!.editDetails}",)));
          }
          else {
            await home.doc(widget.DocID).update({
              "name": name.text,
              "details": details.text,

            });
            Navigator.push(context, HomePage.route());
            ScaffoldMessenger.of(context).showSnackBar
              ( SnackBar(content: Text("${AppLocalizations.of(context)!.edited}",)));
          }
        },
        title: AppLocalizations.of(context)!.update,
        color: (name.text.isEmpty)
            || (details.text.isEmpty) ? Colors.grey : ColorManager.submit);
  }
}
