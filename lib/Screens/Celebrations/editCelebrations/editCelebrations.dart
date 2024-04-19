import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/edit_celebration_cubit.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/core/themes/colors.dart';
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
    return BlocConsumer<EditCelebrationCubit, EditCelebrationState>(
  listener: (context, state) {
    if(state is EditSuccess) {
      Navigator.of(context).pushReplacementNamed("celebrations");
    } else {
      print("loading still fam");
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addCelebration),
      ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                 await url.pickImage();
                  setState(() {
                  });
                },
                child: Center(
                  child: url.url != null ?myImage(
                    src: url.url,
                  ) : SizedBox.shrink(),
                ),
              ),
              padding(child: Text(AppLocalizations.of(context)!.celebrations)),
              CustomTextForm(hinttext: "e.g: Christmas", myController: celebrationName),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.details)),
              CustomTextForm(hinttext: "what we do ", myController: celebrationDetails,
                maxLines: 7,),
              sizedBox(),
              padding(
                child: Center(
                      child: imageButton()
                    ),
                  ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   editButton(),
                   sizedBox(width: 20,),
                   cancelButton()
                 ],
               ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
  imageButton () {
    return
      CustomButton(
        title: AppLocalizations.of(context)!.image,
        onPressed: () async {
          await url.pickImage();
          setState(() {
          });
        },
        color: ColorManager.addEdit,
      );
  }
  cancelButton () {
    return CustomButton(
      onPressed: (){
        Navigator.pop(context);
      },
      title: AppLocalizations.of(context)!.cancel,
      color: ColorManager.delete,
    );
  }
  editButton () {
    return CustomButton(onPressed: () async {
      context.read<EditCelebrationCubit>().EditCelebration(widget.DocID,
          {
            "name": celebrationName.text,
            "details": celebrationDetails.text,
            "image": url.url
          });
    }, title: AppLocalizations.of(context)!.update, color: ColorManager.submit,);
  }
}
