import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Celebrations extends StatelessWidget {
  const Celebrations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Celebrations"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Center(
        child: Text("here you can see the celebrations "),
      ),
    );
  }
}
