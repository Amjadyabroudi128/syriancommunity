import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/icons.dart';

import '../../../Screens/HomePage/editHomePage.dart';
import '../../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class edithomeText extends StatelessWidget {
  const edithomeText({
    super.key,
    required this.name,
    required this.widget,
  });

  final TextEditingController name;
  final EditHome widget;

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(
      label: Text(AppLocalizations.of(context)!.name), myController: name,
      suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear,),
      validator: (value) {
        if(value == null || name.text == widget.oldName) {
          return AppLocalizations.of(context)!.addThings;
        }
        return null;
      },
    );
  }
}
class editDetails extends StatelessWidget {
  const editDetails({
    super.key,
    required this.details,
    required this.widget,
  });

  final TextEditingController details;
  final EditHome widget;

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(
      label: Text(AppLocalizations.of(context)!.details),
      myController: details,
      suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: myIcons.clear ),
      validator: (value) {
        if(value == null || details.text == widget.oldDetail) {
          return AppLocalizations.of(context)!.editDetails;
        }
        return null;
      },
    );
  }
}

