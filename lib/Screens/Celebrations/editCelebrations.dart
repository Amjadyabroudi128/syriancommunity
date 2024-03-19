import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
import '../../classes/pickImage.dart' as url;
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../themes/colors.dart';


class EditCelebration extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  final String? oldUrl;

  const EditCelebration({Key? key, required this.DocID, required this.oldName, required this.oldDetail, this.oldUrl}) : super(key: key);

  @override
  State<EditCelebration> createState() => _EditCelebrationState();
}

class _EditCelebrationState extends State<EditCelebration> {
  TextEditingController celebrationName = TextEditingController();
  TextEditingController celebrationDetails = TextEditingController();

  void initState() {
    super.initState();
    celebrationName.text = widget.oldName;
    celebrationDetails.text = widget.oldDetail;
    url.url = widget.oldUrl;
  }
  final CollectionReference celebrations =
  FirebaseFirestore.instance.collection('Celebrations');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addCelebration),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  url.pickImage();
                },
                child: Center(
                    child: url.url != null ? Image.network(url.url!,
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width,
                    ) : SizedBox.shrink()
                ),
              ),
              padding(child: Text(AppLocalizations.of(context)!.celebrations)),
              CustomTextForm(hinttext: "e.g: Christmas", myController: celebrationName),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.details)),
              CustomTextForm(hinttext: "what we do ", myController: celebrationDetails,
                maxLines: 7,),
              sizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CustomButton(
                    title: "celebration image",
                    onPressed: () async {
                      await url.pickImage();
                      setState(() {
                      });
                    },
                    color: ColorManager.addEdit,
                  ),
                ),
              ),
              Center(
                child: CustomButton(
                    onPressed: () async {
                      if(url.url == null ) {
                        await celebrations.doc(widget.DocID).update(
                          {
                            "name" : celebrationName.text,
                            "details" : celebrationDetails.text
                          }
                        );
                      } else {
                       await celebrations.doc(widget.DocID).update(
                            {
                              "name" : celebrationName.text,
                              "details" : celebrationDetails.text,
                              "image" : url.url,
                            }
                        );
                      }

                      Navigator.of(context).pushNamed("celebrations");
                    },
                    title: AppLocalizations.of(context)!.update, color: ColorManager.addEdit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
