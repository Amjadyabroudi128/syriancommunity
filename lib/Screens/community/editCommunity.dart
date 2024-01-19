import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditCommunity extends StatefulWidget {
  const EditCommunity({Key? key}) : super(key: key);

  @override
  State<EditCommunity> createState() => _EditCommunityState();
}

class _EditCommunityState extends State<EditCommunity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit community "),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
    );
  }
}
