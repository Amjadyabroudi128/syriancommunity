import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
                              width: 270,
                              height: 270,
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
                              child: Center(child: Text(data["details"])),
                            ),
                            height: 120,
                            width: 400,
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

