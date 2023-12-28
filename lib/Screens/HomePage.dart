import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SideDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("Syrian Community"),
        ),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  height: 40,
                  minWidth: 230,
                  color: Colors.grey,
                  child: Text("Add things +"),
                  onPressed: (){},
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
