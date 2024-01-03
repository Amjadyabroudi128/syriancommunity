import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("adding team"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Center(
        child: Text("This is to add members"),
      ),
    );
  }
}
