import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us "),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            CustomButton(
           onPressed: (){
    Navigator.of(context).pushNamed("addcontact");
    },
           title: "Add contact details"),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("contact").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                {
                  if (!snapshot.hasData) {
                    return Center(child: Text("no data yet"));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ,
                    ),
                  );
                }

            )
          ],
      ),
      ),
    );
  }
}
