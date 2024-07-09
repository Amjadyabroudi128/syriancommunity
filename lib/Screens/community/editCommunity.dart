import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
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
  void dispose() {
    super.dispose();
    name;
    details;
    isUpdated;
    url.url;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.editDetails),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("community");
              },
              icon: myIcons.goBack),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox(height: 10,),
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
                sizedBox(height: 3,),
                padding(child: Text(AppLocalizations.of(context)!.name)),
                CustomTextForm(hinttext: "BreakFast Club", myController: name,
                    suffixIcon: IconButton(onPressed: name.clear, icon: Icon(Icons.clear),)
                ),
                sizedBox(height: 5,),
                padding(child: Text(AppLocalizations.of(context)!.details)),
                CustomTextForm(hinttext: "What we do ", myController: details,
                    suffixIcon: IconButton(onPressed: details.clear, icon: Icon(Icons.clear),)
                ),
                sizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(),
                    sizedBox(width: 10,),
                    submitButton(),
                  ],
                ),
                Center(
                    child: imageButton()
                ),
                sizedBox(height: 3,),

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
        showSnackBar(context, AppLocalizations.of(context)!.update, duration: Duration(seconds: 2));
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
        showSnackBar(context, AppLocalizations.of(context)!.editedSuccessfully);
      }
      setState(() {
        isUpdated = true;
      });
    }
      , title:  (widget.oldName == name.text && widget.oldDetails == details.text || name.text.isEmpty || details.text.isEmpty)
        ? "Updating"  : AppLocalizations.of(context)!.update ,
      color:(widget.oldName == name.text && widget.oldDetails == details.text || name.text.isEmpty || details.text.isEmpty)  ? Colors.grey : ColorManager.submit
    );
  }
}


