import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

import '../../components/TextField.dart';
class AddCelebration extends StatefulWidget {
  const AddCelebration({Key? key}) : super(key: key);

  @override
  State<AddCelebration> createState() => _AddCelebrationState();
}

class _AddCelebrationState extends State<AddCelebration> {
  TextEditingController celebrationName = TextEditingController();
  TextEditingController celebrationDetail = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("adding celebrations"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("celebration"),
              ),
              CustomTextForm(hinttext: "e.g: Christmas", myController: celebrationName),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Details"),
              ),
              CustomTextForm(hinttext: "what we do ", myController: celebrationName),
              SizedBox(height: 15,),
              Center(
                child: CustomButton(
                    onPressed: (){

                    }, title: "submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
