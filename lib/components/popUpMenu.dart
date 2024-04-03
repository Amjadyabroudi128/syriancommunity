import 'package:flutter/material.dart';

class MyPopUpMenu extends StatelessWidget {
  final PopupMenuItemBuilder itemBuilder;
  final PopupMenuItemSelected onSelected;
  final AnimationStyle? popUpAnimationStyle;
  const MyPopUpMenu({super.key, required this.itemBuilder, required this.onSelected, this.popUpAnimationStyle, });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      popUpAnimationStyle: popUpAnimationStyle,
    );
  }
}
