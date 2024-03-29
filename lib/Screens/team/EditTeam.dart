
import 'package:flutter/cupertino.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/themes/colors.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import '../../themes/fontSize.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMember extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  final String? oldUrl;

  const EditMember({Key? key, required this.DocID, required this.oldName, required this.oldDetail,  this.oldUrl, this.document,}) : super(key: key);

  @override
  State<EditMember> createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();

  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetail;
    url.url = widget.oldUrl;
  }
  final CollectionReference members =
  FirebaseFirestore.instance.collection('members');
  @override
  Widget build(BuildContext context) {

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
                GestureDetector(
                  onTap: () async {
                    await url.pickImage();
                    setState(() {
                    });
                  },
                  child: Card(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: url.url != null ? Image.network(url.url!,
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ) : SizedBox.shrink()
                    ),
                  ),
                ),
                padding(child: Text(AppLocalizations.of(context)!.name, style: TextStyles.font14green,)),
                CustomTextForm(hinttext: "name", myController: name,
                    suffixIcon: IconButton(onPressed: name.clear, icon: Icon(Icons.clear), color: Colors.black,)

                ),
                sizedBox(height: 20,),
                padding(child: Text(AppLocalizations.of(context)!.details, style: TextStyles.font14green,)),
                CustomTextForm(
                  maxLines: 5,
                    hinttext: "details",
                    myController: details,
                    suffixIcon: IconButton(onPressed: details.clear, icon: Icon(Icons.clear), color: Colors.black,)

                ),
                sizedBox(height: 2,),
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
                sizedBox(height: 5,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     CustomButton(
                          onPressed: () async {
                            await members.doc(widget.DocID).update(
                                {
                                  "image" : url.url,
                                  "name" : name.text,
                                  "details" : details.text
                                }
                            );
                            Navigator.pop(context);
                          },
                       title: AppLocalizations.of(context)!.edit, color: ColorManager.submit,),
                     sizedBox(width: 16,),
                     CustomButton(onPressed: (){
                       Navigator.pop(context);

                     }, title: AppLocalizations.of(context)!.cancel, color: ColorManager.delete,),
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
