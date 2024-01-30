import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();

  String formattedDate(timeStamp){
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds *1000);
    return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
  }
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text("Name"),
                ),
                  CustomTextForm(
                      hinttext: "name",
                      myController: name),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text("Details"),
                ),
                CustomTextForm(
                    hinttext: "details",
                    myController: details),
                SizedBox(height: 15,),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                       await FirebaseFirestore.instance.collection("home").doc().set(
                         {
                         "name" : name.text,
                           "details" : details.text,
                           "time" : DateTime.now(),
                         }
                       );
                       clearText();
                       Navigator.of(context).pushNamed("homepage");
                      },
                      title: "Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void clearText() {
    name.clear();
    details.clear();
  }

}
