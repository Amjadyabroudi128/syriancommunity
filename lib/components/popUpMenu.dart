import 'package:flutter/material.dart';

class MyPopUpMenu extends StatelessWidget {
  final PopupMenuItemBuilder itemBuilder;
  final PopupMenuItemSelected onSelected;
  const MyPopUpMenu({super.key, required this.itemBuilder, required this.onSelected, });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: itemBuilder,
      onSelected: onSelected,
    );
  }
}
