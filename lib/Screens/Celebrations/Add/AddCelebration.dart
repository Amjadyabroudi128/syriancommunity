import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Screens/Celebrations/Add/add_celebration_cubit.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../../components/TextField.dart';
class AddCelebration extends StatefulWidget {
  const AddCelebration({Key? key}) : super(key: key);

  @override
  State<AddCelebration> createState() => _AddCelebrationState();
}

class _AddCelebrationState extends State<AddCelebration> {
 late final TextEditingController celebrationName = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late final TextEditingController celebrationDetail = TextEditingController()..addListener(() {
    setState(() {
    });
  });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCelebrationCubit, AddCelebrationState>(
  listener: (context, state) {
    if (state is AddSuccess) {
      Navigator.of(context).pushReplacementNamed("celebrations");
      clearText();
    }
    else if ( state is AddLoading){
      print("still loading data");

    }
  },
  builder: (context, state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
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
                    suffixIcon: celebrationName.text.isEmpty? null :
                    IconButton(onPressed: celebrationName.clear, icon: myIcons.clear,)
                ),
                sizedBox(),
                padding(child: Text(AppLocalizations.of(context)!.details),),
                CustomTextForm(hinttext: "what we do ", myController: celebrationDetail, maxLines: 6,
                    suffixIcon: celebrationDetail.text.isEmpty ?
                    null : IconButton(onPressed: celebrationDetail.clear, icon: myIcons.clear,),
                    ),
                sizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: imageButton()
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     cancelButton(),
                     sizedBox(width: 20,),
                     addButton(),
                   ],
                 ),
              ],
            ),
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
        await context.read<AddCelebrationCubit>().addCelebration(
            url: url.url,
            name: celebrationName.text,
            details: celebrationDetail.text);

      },
      title: AppLocalizations.of(context)!.submit, color:ColorManager.submit,);
  }

}
