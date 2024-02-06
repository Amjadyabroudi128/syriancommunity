import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/TextField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final adminEmail = TextEditingController();
  // final adminPass = TextEditingController();
  String testEmail = "SussexCommunity@syrian.com";
  String testPassword = "Syria963";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
        title: Text("Login screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Log in as an admin to add things to the pages"),
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
            // ),
            CustomTextForm(hinttext: "email",),
            SizedBox(
              height: 13,
            ),
            // TextFormField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: "Password",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(25.0),
            //     ),
            //   ),
            // ),
            CustomTextForm(hinttext: "pass",),
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
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: testEmail, password: testPassword);
                  Navigator.of(context).pushNamed("homepage");
                },
                child: const Text(
                  'Login',
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
