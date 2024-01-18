import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditLearning extends StatefulWidget {
  const EditLearning({Key? key}) : super(key: key);

  @override
  State<EditLearning> createState() => _EditLearningState();
}

class _EditLearningState extends State<EditLearning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Learning "),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
    );
  }
}
