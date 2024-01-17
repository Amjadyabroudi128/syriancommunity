import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningResources extends StatefulWidget {
  const LearningResources({Key? key}) : super(key: key);

  @override
  State<LearningResources> createState() => _LearningResourcesState();
}

class _LearningResourcesState extends State<LearningResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Learning resources"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
    );
  }
}
