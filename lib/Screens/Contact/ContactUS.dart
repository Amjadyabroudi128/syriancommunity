import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Contact/Edit.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
            body: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: SingleChildScrollView(
                child: Center(
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
                                ListView(
                                  physics: ScrollPhysics(),
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
                                              elevation: 0,
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
                                                              EditDetails(DocID: document.id,
                                                                oldPlace: data["place"],
                                                                oldRoad: data["street name"],
                                                                oldCity: data["city"],
                                                                oldEmail: data["email"],
                                                                oldPHone: data["phone"],
                                                                oldPostCode: data["post code"],)));
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
                                          Text("Or you can Contact us through email or phone", style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),),
                                          SizedBox(height: 13,),
                                          Container(
                                            height: 200,
                                            width: 400,
                                            child: Card(
                                              elevation: 0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Text("Email ${data["email"]}"),
                                                  ),
                                                  SizedBox(height: 14,),
                                                  Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Text("Ahmad Yabroudi  ${data["phone"]}"),
                                                  ),
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
                                                                EditDetails(DocID: document.id,
                                                                  oldPlace: data["place"],
                                                                  oldRoad: data["street name"],
                                                                  oldCity: data["city"],
                                                                  oldEmail: data["email"],
                                                                  oldPHone: data["phone"],
                                                                  oldPostCode: data["post code"],)));
                                                      },
                                                          icon: Icon(Icons.edit,)
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );

                                  }).toList(),
                                );
                          }
                        ),
                        Text("OUR LOCATION "),
                        SizedBox(height: 12,),
                        Center(
                          child: Container(
                            height: 300,
                            width: 300,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(50.82062318563144, -0.12208351759729541),
                                zoom: 14,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId("college"),
                                  position: LatLng(50.82062318563144, -0.12208351759729541),
                                  draggable: true,
                                  onDragEnd: (value) {

                                  }
                                )
                              },
                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                ),
              ),
            ),

    );
  }
}
