import 'package:flutter/material.dart';

class MyPopUpMenu extends StatelessWidget {
  final PopupMenuItemBuilder itemBuilder;
  final PopupMenuItemSelected onSelected;
  final AnimationStyle? popUpAnimationStyle;
  final Widget? icon;
  const MyPopUpMenu({super.key, required this.itemBuilder, required this.onSelected, this.popUpAnimationStyle, this.icon, });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: icon,
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      popUpAnimationStyle: popUpAnimationStyle,
    );
  }
}
