import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/SubmitButton.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            CustomButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("addcelebration");
                },
                title: "Add celebrations")
          ],

        ),
      ),
    );
  }
}
