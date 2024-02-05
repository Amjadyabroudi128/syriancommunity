import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/TextField.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final adminEmail = TextEditingController();
  final adminPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
        title: Text("Signup screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOG in as an adming to add things to the pages"),
            SizedBox(
              height: 15,
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: "Email",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(25.0),
            //     ),
            //   ),
            //   validator: (value) =>
            //   value != adminEmail ? "Wrong email" : null,
            //   onChanged: (value) {
            //
            //   },
            // ),
            CustomTextForm(hinttext: "email", myController: adminEmail),
            SizedBox(
              height: 13,
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: "Password",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(25.0),
            //     ),
            //   ),
            //   validator: (value) =>
            //   value != adminPass ? "Wrong pass" : null,
            //   onChanged: (value) {
            //
            //   },
            // ),
            CustomTextForm(hinttext: "pass", myController: adminPass),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: adminEmail.text, password: adminPass.text);
                  Navigator.of(context).pushNamed("homepage");
                },
                child: const Text(
                  'Signup  ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
