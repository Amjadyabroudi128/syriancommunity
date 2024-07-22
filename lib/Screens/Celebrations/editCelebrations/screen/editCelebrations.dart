import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/controller/edit_celebration_bloc.dart';
import 'package:syrianadmin/classes/pickImage.dart' as url;
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/themes/colors.dart';

class EditCelebration extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  final String? oldUrl;

  const EditCelebration(
      {Key? key,
      required this.DocID,
      required this.oldName,
      required this.oldDetail,
      this.oldUrl})
      : super(key: key);

  @override
  State<EditCelebration> createState() => _EditCelebrationState();
}

class _EditCelebrationState extends State<EditCelebration> {
  late final TextEditingController celebrationName = TextEditingController()
    ..addListener(() {
      setState(() {});
    });
  late final TextEditingController celebrationDetails = TextEditingController()
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    super.initState();
    celebrationName.text = widget.oldName;
    celebrationDetails.text = widget.oldDetail;
    url.url = widget.oldUrl;
  }

  @override
  Widget build(BuildContext context) {
    String title = AppLocalizations.of(context)!.editDetails;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocListener<EditCelebrationBloc, EditCelebrationState>(
                listener: (context, state) {
                  if (state is EditSuccess) {
                    Navigator.of(context).pushReplacementNamed("celebrations");
                    showSnackBar(context, AppLocalizations.of(context)!.editedSuccessfully);
                  }
                  else if ( state is EditFailure){
                    showSnackBar(context, state.errMessage);
                  }
                },
                child: Form(
                  key: Validate.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox(
                        height: 20,
                      ),
                      Center(
                        child: url.url != null
                            ? myImage(
                                onPressed: () async {
                                  await url.pickImage();
                                  setState(() {});
                                },
                                src: url.url,
                              )
                            : SizedBox.shrink(),
                      ),
                      padding(
                          child:
                              Text(AppLocalizations.of(context)!.celebrations)),
                      CustomTextForm(
                        suffixIcon: celebrationName.text.isEmpty || celebrationName == widget.oldName
                            ? null
                            : IconButton(
                                onPressed: celebrationName.clear,
                                icon: myIcons.clear,
                              ),
                        label:
                            Text(AppLocalizations.of(context)!.celebrationName),
                        myController: celebrationName,
                        validator: (value) {
                          if (value == widget.oldName) {
                            return "\u2757 ${AppLocalizations.of(context)!.editDetails}";
                          }
                          if (celebrationName.text.isEmpty) {
                            return AppLocalizations.of(context)!.addThings;
                          }
                          return null;
                        },
                      ),
                      sizedBox(
                        height: 7.h,
                      ),
                      padding(
                          child: Text(AppLocalizations.of(context)!.details)),
                      sizedBox(
                        height: 4.h,
                      ),
                      CustomTextForm(
                        suffixIcon: celebrationDetails.text.isEmpty || celebrationDetails == widget.oldDetail ? null
                            : IconButton(
                                onPressed: celebrationDetails.clear,
                                icon: myIcons.clear,
                              ),
                        label: Text(AppLocalizations.of(context)!.whatWeDo),
                        myController: celebrationDetails,
                        validator: (value) {
                          if (value == widget.oldDetail) {
                            return "\u2757 ${AppLocalizations.of(context)!.editDetails}";
                          }
                          if (celebrationDetails.text.isEmpty) {
                            return AppLocalizations.of(context)!.addThings;
                          }
                          return null;
                        },
                      ),
                      sizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cancelButton(),
                          sizedBox(
                            width: 10.w,
                          ),
                          editButton(),
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
      ),
    );
  }

  imageButton() {
    return CustomButton(
      title: AppLocalizations.of(context)!.image,
      onPressed: () async {
        await url.pickImage();
        setState(() {});
      },
      color: ColorManager.addEdit,
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

  editButton() {
    String btnTitle = AppLocalizations.of(context)!.update;
    bool isChangedorEmpty = celebrationName.text == widget.oldName &&
        celebrationDetails.text == widget.oldDetail ||
        celebrationName.text.isEmpty ||
        celebrationDetails.text.isEmpty;
    Color btnClr = (widget.oldName == celebrationName.text && widget.oldDetail == celebrationDetails.text ||
        celebrationName.text.isEmpty || celebrationDetails.text.isEmpty)  ? ColorManager.emptyLogin : ColorManager.submit;
    return CustomButton(
      onPressed: () async {
        if (isChangedorEmpty) {
          Validate.validating();
          showSnackBar(context, AppLocalizations.of(context)!.addThings);
        } else {
          BlocProvider.of<EditCelebrationBloc>(context).add(
            editCelebration(DocID: widget.DocID, newData: {
                "name": celebrationName.text,
                "details": celebrationDetails.text,
                "image": url.url
            })
          );
          Validate.formKey.currentState!.reset();
        }
      },
      title: btnTitle,
      color: btnClr
    );
  }
}
