import 'package:flutter/material.dart';
import '../../components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class textDetails extends StatelessWidget {
  const textDetails({
    super.key,
    required this.details,
  });

  final TextEditingController details;

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(label: Text(AppLocalizations.of(context)!.details), myController: details,
      suffixIcon: details.text.isEmpty ? null : IconButton(onPressed: details.clear, icon: myIcons.clear),
      validator: (value) {
        if(value == null || details.text.isEmpty) {
          return "\u2757 ${AppLocalizations.of(context)!.addThings}";
        }
        return null;
      },
    );
  }
}
