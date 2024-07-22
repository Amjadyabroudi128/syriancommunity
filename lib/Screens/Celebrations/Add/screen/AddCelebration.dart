import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import '../../../../components/TextField.dart';
import '../controller/add_bloc.dart';

class AddCelebration extends StatefulWidget {
  const AddCelebration({Key? key}) : super(key: key);

  @override
  State<AddCelebration> createState() => _AddCelebrationState();
}

class _AddCelebrationState extends State<AddCelebration> {
  late final TextEditingController celebrationName = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  late final TextEditingController celebrationDetail = TextEditingController()
    ..addListener(() {
      setState(() {});
    });

  @override
  Widget build(BuildContext context) {
    String appBarTitle = AppLocalizations.of(context)!.addCelebration;
    return  GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        if (state is AddSuccess) {
          Navigator.of(context).pushReplacementNamed("celebrations");
          showSnackBar(context, AppLocalizations.of(context)!.addedSuccessfully);
          clearText();
        }
        else if ( state is AddFailure){
          showSnackBar(context, state.errMessage);
        }
      },
          child: Scaffold(
            appBar: AppBar(
              leading: goBack(
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed("celebrations");
                },
              ),
              title: Text(appBarTitle),
            ),
            body: padding(
              child: SingleChildScrollView(
                child: Form(
                  key: Validate.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      padding(
                          child:
                          Text(AppLocalizations.of(context)!.celebrations)),
                       CustomTextForm(
                          myController: celebrationName,
                          label:
                          Text(AppLocalizations.of(context)!.celebrationName),
                          suffixIcon: celebrationName.text.isEmpty
                              ? null
                              : IconButton(
                            onPressed: celebrationName.clear,
                            icon: myIcons.clear,
                          ),
                          validator: (value) {
                            if (value == null || celebrationName.text.isEmpty) {
                              return "\u2757 ${AppLocalizations.of(context)!.addCelebration}";
                            }
                            return null;
                          },
                        ),
                      sizedBox(),
                      padding(
                        child: Text(AppLocalizations.of(context)!.details),
                      ),
                      CustomTextForm(
                        myController: celebrationDetail,
                        label: Text(AppLocalizations.of(context)!.whatWeDo),
                        suffixIcon: celebrationDetail.text.isEmpty
                            ? null
                            : IconButton(
                          onPressed: celebrationDetail.clear,
                          icon: myIcons.clear,
                        ),
                        validator: (value) {
                          if (value == null || celebrationDetail.text.isEmpty) {
                            return "\u2757 ${AppLocalizations.of(context)!.addDetails}";
                          }
                          return null;
                        },
                      ),
                      sizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cancelButton(),
                          sizedBox(
                            width: 15.w,
                          ),
                          addButton(),
                        ],
                      ),
                      Center(
                        child: imageButton(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }

  void clearText() {
    celebrationName.clear();
    celebrationDetail.clear();
  }

  imageButton() {
    return Center(
      child: CustomButton(
        title: AppLocalizations.of(context)!.image,
        onPressed: () {
          url.pickImage();
          setState(() {});
        },
        color: ColorManager.addEdit,
      ),
    );
  }

  cancelButton() {
    return CustomButton(
      onPressed: () {
        Navigator.pop(context);
      },
      title: AppLocalizations.of(context)!.cancel,
      color: ColorManager.delete,
    );
  }

  addButton() {
    bool isEmpty = celebrationName.text.isEmpty || celebrationDetail.text.isEmpty;
    String btnTitle = AppLocalizations.of(context)!.submit;
    Color btnClr = (celebrationName.text.isEmpty) || (celebrationDetail.text.isEmpty) ? ColorManager.emptyLogin: ColorManager.submit;
    return CustomButton(
        onPressed: () async {
          if (isEmpty) {
            Validate.validating();
          } else {
            context.read<AddBloc>().add(
              addCelebration(name: celebrationName.text, details: celebrationDetail.text)
            );
            Validate.formKey.currentState!.reset();
          }
        },
        title: btnTitle,
        color: btnClr
    );
  }
}
