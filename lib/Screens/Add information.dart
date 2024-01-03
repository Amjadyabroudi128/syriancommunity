import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("adding to home page "),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Name"),
            ],
          ),
        ),
      ),
    );
  }
}
