import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/add_celebration_cubit.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../components/TextField.dart';
import 'CelebrationView.dart';
class AddCelebration extends StatefulWidget {
  const AddCelebration({Key? key}) : super(key: key);

  @override
  State<AddCelebration> createState() => _AddCelebrationState();
}

class _AddCelebrationState extends State<AddCelebration> {
  TextEditingController celebrationName = TextEditingController();
  TextEditingController celebrationDetail = TextEditingController();

  final CollectionReference celebrations =
  FirebaseFirestore.instance.collection('Celebrations');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCelebrationCubit, AddCelebrationState>(
  listener: (context, state) {
    if (state is AddSuccess) {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => Celebrations()
          )
      );
      clearText();
    }
    else if ( state is AddLoading){
      print("still loading data");

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
              padding(child: Text(AppLocalizations.of(context)!.celebrations)),
              CustomTextForm(hinttext: "e.g: Christmas", myController: celebrationName,
                  suffixIcon: IconButton(onPressed: celebrationName.clear, icon: Icon(Icons.clear), color: Colors.black,)

              ),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.details),),
              CustomTextForm(hinttext: "what we do ", myController: celebrationDetail, maxLines: 6,
                  suffixIcon: IconButton(onPressed: celebrationDetail.clear, icon: Icon(Icons.clear), color: Colors.black,
                  )

              ),
              sizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: imageButton()
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   addButton(),
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
  void clearText() {
    celebrationName.clear();
    celebrationDetail.clear();
  }
  imageButton () {
     return Center(
      child: CustomButton(
        title: AppLocalizations.of(context)!.image,
        onPressed: () {
          url.pickImage();
          setState(() {
          });
        },
        color: ColorManager.addEdit,
      ),
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
  addButton () {
   return  CustomButton(
      onPressed: ()async {
        await BlocProvider.of<AddCelebrationCubit>(context).addCelebration(
            url: url.url,
            name: celebrationName.text,
            details: celebrationDetail.text);
      },
      title: AppLocalizations.of(context)!.submit, color:ColorManager.submit,);
  }
}
