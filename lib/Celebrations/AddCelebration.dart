import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCelebration extends StatefulWidget {
  const AddCelebration({Key? key}) : super(key: key);

  @override
  State<AddCelebration> createState() => _AddCelebrationState();
}

class _AddCelebrationState extends State<AddCelebration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is a place to add celebrations"),
      ),
    );
  }
}
