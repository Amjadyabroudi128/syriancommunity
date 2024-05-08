import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../components/SubmitButton.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../classes/pickImage.dart' as url;
import '../../components/image.network.dart';
class EditCommunity extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetails;
  final String? oldUrl;
  const EditCommunity({Key? key, required this.DocID, required this.oldName, required this.oldDetails, this.oldUrl,}) : super(key: key);

  @override
  State<EditCommunity> createState() => _EditCommunityState();
}

class _EditCommunityState extends State<EditCommunity> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();

  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetails;
    url.url = widget.oldUrl;
    isUpdated = false;
  }
   bool? isUpdated;
  final CollectionReference community =
  FirebaseFirestore.instance.collection('Community');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.editDetails),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await url.pickImage();
                    setState(() {
                    });
                  },
                  child: Center(
                    child: url.url != null ?myImage(
                      src: url.url,
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width,
                    ) : SizedBox.shrink(),
                  ),
                ),
                sizedBox(),
                padding(child: Text(AppLocalizations.of(context)!.name)),
                CustomTextForm(hinttext: "BreakFast Club", myController: name,
                    suffixIcon: IconButton(onPressed: name.clear, icon: Icon(Icons.clear),)
                ),
                sizedBox(),
                padding(child: Text(AppLocalizations.of(context)!.details)),
                CustomTextForm(hinttext: "What we do ", myController: details,
                    suffixIcon: IconButton(onPressed: details.clear, icon: Icon(Icons.clear),)
                ),
                sizedBox(),
                Center(
                    child: imageButton()
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(),
                    sizedBox(width: 15,),
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
  cancelButton() {
    return CustomButton(
      onPressed: (){
        Navigator.pop(context);
      },
      title: AppLocalizations.of(context)!.cancel,
      color: ColorManager.delete,
    );
  }
  submitButton () {
    return CustomButton(
      onPressed: () async {
      if(widget.oldName == name.text && widget.oldDetails == details.text) {
        ScaffoldMessenger.of(context).showSnackBar
          ( SnackBar(content: Text("please update somethings"), duration: Duration(seconds: 1),));
        setState(() {
          isUpdated = false;
        });
      } else {
        await community.doc(widget.DocID).update({
          "name" : name.text,
          "details" : details.text,
          "image" : url.url
        });
        Navigator.pop(context);
      }
      setState(() {
        isUpdated = true;
      });
    }
      , title:  (widget.oldName == name.text && widget.oldDetails == details.text)
        ? "Updating"  : AppLocalizations.of(context)!.update ,
      color:(widget.oldName == name.text && widget.oldDetails == details.text)  ? Colors.grey : ColorManager.submit
    );
  }
}


