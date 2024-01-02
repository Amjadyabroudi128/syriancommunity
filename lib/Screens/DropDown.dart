import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Add%20information.dart';
import 'package:syrianadmin/Screens/HomePage.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var selectedItem ;
  final _widgetOptions = [
    HomePage(),
    AddInfo(),
  ];

  void _onItemTapped() {
    setState(() {
      selectedItem ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        "homepage",
        "addInfo",
      ].map((e) => DropdownMenuItem
        (child: Text("$e"), value: e,)).toList(),
      onChanged: (val) {
        setState(() {
          selectedItem = val!;
        });
      },
      value: selectedItem,
      onTap: _onItemTapped,
    );
  }
}
