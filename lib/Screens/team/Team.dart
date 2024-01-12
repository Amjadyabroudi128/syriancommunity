import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

import 'EditTeam.dart';


class MeetOurTeam extends StatefulWidget {
  final document;
  const MeetOurTeam({@required this.document});

  @override
  State<MeetOurTeam> createState() => _MeetOurTeamState();
}

class _MeetOurTeamState extends State<MeetOurTeam> {
  final CollectionReference members =
  FirebaseFirestore.instance.collection('members');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("our tean"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("addMember");

                },
                title: "Add members +",
              ),
            ),
            StreamBuilder(
              stream: members.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return SingleChildScrollView(
                    child: ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Column(
                        children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              data["image"],
                              width: 240,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                          Text(data["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
                            color: Color.fromARGB(255, 33, 173, 168),),),
                          SizedBox(height: 12,),
                          Container(
                            child: Card(
                              color: Colors.grey[300],
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(data["details"], style: TextStyle(fontSize: 17),),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) =>
                                                  EditMember(DocID: document.id ,
                                                    oldName: data["name"],
                                                    oldDetail: data["details"],
                                                    oldUrl: data["image"],)
                                          ));
                                        },
                                        icon: Icon(
                                            Icons.edit
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance.collection("members").doc(document.id).delete();
                                          Navigator.of(context).pushNamed("ourteam");
                                        },
                                        icon: Icon(
                                            Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ],
                              ),
                            ),
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      );
                    },
                    ).toList(),
                    ),
                  );
                },
            )
          ],
        ),
      ),
    );
  }
}

