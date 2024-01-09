import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Contact/Edit.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

class ContactUs extends StatefulWidget {
  final document;
  const ContactUs({ @required this.document});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final CollectionReference contact =
  FirebaseFirestore.instance.collection('contact');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us"),
        centerTitle: true,
         backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("addcontact");
                          },
                          title: "Add contact details"),
                    ),
                    SizedBox(height: 30,),
                    Text("You can visit us here ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    StreamBuilder <QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("contact").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          return 
                            SingleChildScrollView(
                              child: ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 400,
                                        child: Card(
                                          color: Colors.grey[300],
                                          child: Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                        Text("our Address"),
                                                        SizedBox(height: 10,),
                                                        Text(data["place"]),
                                                        SizedBox(height: 10,),
                                                        Text(data["street name"]),
                                                        SizedBox(height: 10,),
                                                        Text(data["city"]),
                                                        SizedBox(height: 10,),
                                                        Text(data["post code"]),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(onPressed: () async{
                                                      await FirebaseFirestore.instance.collection("contact").doc(document.id).delete();
                                                      Navigator.of(context).pushNamed("contactus");

                                                    },
                                                        icon: Icon(Icons.delete, color: Colors.red,)
                                                    ),
                                                    IconButton(onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context) =>
                                                          EditDetails(DocID: document.id,)));
                                                    },
                                                        icon: Icon(Icons.edit,)
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                                );

                              }).toList(),
                        ),
                            );
                      }
                    ),

                  ],
                ),

              ),
            ),

    );
  }
}
