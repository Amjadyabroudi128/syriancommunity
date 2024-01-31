import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../SideDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formattedDate(timeStamp){
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds *1000);
    return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.list),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        toolbarHeight: 70,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("Syrian Community"),
        ),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      drawer: SideDrawer(),
      // i prefer the drawer to the DropDownMenu
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  height: 40,
                  minWidth: 230,
                  color: Colors.grey,
                  child: Text("Add things +"),
                  onPressed: (){
                    Navigator.of(context).pushNamed("addInfo");
                  },
                ),
                SizedBox(height: 12,),
                Text("here you will see the latest news for the Community"),
              ],
            )
          ],
        ),
      )
    );
  }
}
