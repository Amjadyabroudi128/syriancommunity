import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddLearning extends StatefulWidget {
  const AddLearning({Key? key}) : super(key: key);

  @override
  State<AddLearning> createState() => _AddLearningState();
}

class _AddLearningState extends State<AddLearning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is for adding things "),
      ),
    );
  }
}
