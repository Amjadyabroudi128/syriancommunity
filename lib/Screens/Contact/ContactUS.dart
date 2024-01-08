import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  children: [
                    CustomButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed("addcontact");
                        },
                        title: "Add contact details"),
                    StreamBuilder <QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("contact").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              return ListTile(
                                title: Text(data['street name']),
                                subtitle: Text(data['post code']),
                              );
                            }).toList(),
                        );
                      }
                    ),
                  ],
                ),

              ),
            ),
            // StreamBuilder <QuerySnapshot>(
            //   stream: FirebaseFirestore.instance.collection("contact").snapshots(),
            //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('Something went wrong');
            //       }
            //
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Text("Loading");
            //       }
            //
            //       return ListView(
            //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //           Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            //           return ListTile(
            //             title: Text(data['street name']),
            //             subtitle: Text(data['post code']),
            //           );
            //         }).toList(),
            //     );
            //
            //   }
            // )
    );
  }
}

// class ContactUs extends StatelessWidget {
//   ContactUs({required this.document});
//   final document;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contact us "),
//         backgroundColor: Color.fromARGB(255, 33, 173, 168),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: ListView(
//           children: [
//             CustomButton(
//            onPressed: (){
//     Navigator.of(context).pushNamed("addcontact");
//     },
//            title: "Add contact details"),
//             StreamBuilder(
//               stream: FirebaseFirestore.instance.collection("contact").snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
//                 {
//                   if (!snapshot.hasData) {
//                     return Center(child: Text("no data yet"));
//                   }
//                   return ListView(
//
//                   );
//                 }
//
//             )
//           ],
//       ),
//       ),
//     );
//   }
// }
