import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("community"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CustomButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed("addCommunity");
                    },
                    title: "add community "),
              ),
            )
          ],
        ),
      ),
    );
  }
}
