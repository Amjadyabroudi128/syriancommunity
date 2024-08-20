import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/TextField.dart';
import '../../components/icons.dart';

class textName extends StatelessWidget {
  const textName({
    super.key,
    required this.name,
  });

  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(label: Text(AppLocalizations.of(context)!.name), myController: name,
      suffixIcon: name.text.isEmpty? null : IconButton(onPressed: name.clear, icon: myIcons.clear),
      validator: (value) {
        if(value == null || name.text.isEmpty) {
          return "\u2757 ${AppLocalizations.of(context)!.addThings}";
        }
        return null;
      },
    );
  }
}
