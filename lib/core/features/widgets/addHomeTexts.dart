import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/icons.dart';

import '../../../components/Sizedbox.dart';

class textDetails extends StatelessWidget {
  const textDetails({
    super.key,
    required this.details,
    required bool showIcon,
  }) : _showIcon = showIcon;

  final TextEditingController details;
  final bool _showIcon;

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(
      label: Text(AppLocalizations.of(context)!.details),
      myController: details,
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _showIcon ? myIcons.error : SizedBox.shrink(),
          details.text.isEmpty ? sizedBox() : IconButton(onPressed: details.clear,
            icon: myIcons.clear,),
        ],
      ),
      validator: (value) {
        if(value == null || details.text.isEmpty) {
          return AppLocalizations.of(context)!.addDetails;
        }
        return null;
      },
    );
  }
}
class nameText extends StatelessWidget {
  const nameText({
    super.key,
    required this.name,
    required bool showIcon,
  }) : _showIcon = showIcon;

  final TextEditingController name;
  final bool _showIcon;

  @override
  Widget build(BuildContext context) {
    return CustomTextForm(
      label: Text(AppLocalizations.of(context)!.name),
      myController: name,
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _showIcon ? myIcons.error : SizedBox.shrink(),
          name.text.isEmpty ? sizedBox() : IconButton(onPressed: name.clear,
            icon: myIcons.clear,),
        ],
      ),
      // _showIcon ? Icon(Icons.warning) : sizedBox(),
      validator: (value) {
        if(value == null || name.text.isEmpty) {
          return AppLocalizations.of(context)!.addThings;
        }
        return null;
      },
    );
  }
}