
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

  const EditMember({Key? key, required this.DocID, required this.oldName, required this.oldDetail,  this.oldUrl,}) : super(key: key);

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
                Card(
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
                padding(child: Text("Name", style: TextStyles.font14green,)),
                CustomTextForm(hinttext: "name", myController: name),
                sizedBox(height: 20,),
                padding(child: Text("Details", style: TextStyles.font14green,)),
                CustomTextForm(
                  maxLines: 5,
                    hinttext: "details",
                    myController: details),
                sizedBox(),
                Center(
                  child: CustomButton(
                    title: "get image",
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
                          title: "Edit", color: ColorManager.addEdit,),
                     sizedBox(width: 16,),
                     CustomButton(onPressed: (){
                       Navigator.pop(context);

                     }, title: ""),
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
