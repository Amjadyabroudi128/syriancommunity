import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditHome extends StatefulWidget {
  final String DocID;
  final String oldName;
  final String oldDetail;
  const EditHome({Key? key, required this.DocID, required this.oldName, required this.oldDetail}) : super(key: key);

  @override
  State<EditHome> createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  TextEditingController name = TextEditingController();
  TextEditingController details = TextEditingController();
  void initState() {
    super.initState();
    name.text = widget.oldName;
    details.text = widget.oldDetail;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text("Name"),
                ),
                CustomTextForm(
                    hinttext: "name",
                    myController: name),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Text("Details"),
                ),
                CustomTextForm(
                  hinttext: "details",
                  myController: details,
                  maxLines: 6,
                ),
                SizedBox(height: 15,),
                Center(
                  child: CustomButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection("home").doc().set(
                            {
                              "name" : name.text,
                              "details" : details.text,
                              "time" : DateTime.now(),
                            }
                        );
                        clearText();
                        Navigator.of(context).pushNamed("homepage");
                      },
                      title: "Submit"),
                )
              ],
            ),
          ),
        ),
      ),,
    );
  }
}
