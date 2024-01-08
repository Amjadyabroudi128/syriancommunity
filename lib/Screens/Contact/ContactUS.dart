import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

class ContactUs extends StatefulWidget {
  final document;
  const ContactUs({Key? key, this.document}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact us"),
        centerTitle: true,
         backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: ListView(
          children: [
            CustomButton(
           onPressed: (){
               Navigator.of(context).pushNamed("addcontact");
               },
           title: "Add contact details"),
            StreamBuilder(

            )
          ],
        ),
      ),
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
