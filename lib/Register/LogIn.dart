import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/auth_cubit.dart';
import 'package:syrianadmin/components/TextField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String testEmail = "SussexCommunity@gmail.com";
  String testPassword = "Syria963";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is LoginSuccess)  {
      Navigator.of(context).pushNamed("homepage");
    } else if (state is LoginLoading) {

    }
  },
  builder: (context, state) {
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
            CustomTextForm(hinttext: "email",),
            SizedBox(
              height: 13,
            ),
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

                  BlocProvider.of<AuthCubit>(context).login(email: testEmail, password: testPassword);
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
  },
);
  }
}