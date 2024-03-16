import 'package:flutter/material.dart';

class MyPopUpMenu extends StatelessWidget {
  final PopupMenuItemBuilder itemBuilder;
  final PopupMenuItemSelected onSelected;
  final double? iconSize;
  const MyPopUpMenu({super.key, required this.itemBuilder, required this.onSelected, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      iconSize: 30,
    );
  }
}
