import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditCelebration extends StatefulWidget {
  const EditCelebration({Key? key}) : super(key: key);

  @override
  State<EditCelebration> createState() => _EditCelebrationState();
}

class _EditCelebrationState extends State<EditCelebration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("edit celebrations "),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
    );
  }
}
