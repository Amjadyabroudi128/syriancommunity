import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user = FirebaseAuth.instance.currentUser;

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
                  if (snapshot.data!.docs.isEmpty) {
                    return SafeArea(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 200,),
                            Text("nothing to see here yet :( ", style: TextStyle(color: Colors.grey, fontSize: 20),)
                          ],
                        ),
                      ),
                    );
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
                          child: user != null ? GestureDetector(
                            child: Card(
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: data["image"] != null ? Image.network(
                                data["image"],
                                width: 240,
                                height: 240,
                                fit: BoxFit.cover,
                              ) : SizedBox.shrink(),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      EditMember(DocID: document.id ,
                                        oldName: data["name"],
                                        oldDetail: data["details"],
                                        oldUrl: data["image"],)
                                  ));
                            },
                          ) : Card(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: data["image"] != null ? Image.network(
                              data["image"],
                              width: 240,
                              height: 240,
                              fit: BoxFit.cover,
                            ) : SizedBox.shrink(),
                          ),
                        ),
                          Text(data["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
                            color: Color.fromARGB(255, 33, 173, 168),),),
                          SizedBox(height: 12,),
                          Container(
                            // height: 160,
                            width: MediaQuery.of(context).size.width,
                            child: IntrinsicHeight(
                              child: Card(
                                elevation: 0,
                                color: Colors.grey[300],
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(data["details"], style: TextStyle(fontSize: 17),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 310),
                                      child: user != null ? PopupMenuButton(
                                        iconSize: 30,
                                        // add icon, by default "3 dot" icon
                                        // icon: Icon(Icons.book)
                                        itemBuilder: (context){
                                          return [
                                            PopupMenuItem<int>(
                                                value: 0,
                                                child:Icon(Icons.edit)
                                            ),

                                            PopupMenuItem<int>(
                                              value: 1,
                                              child: Icon(Icons.delete, color: Colors.red,),
                                            ),
                                          ];
                                        },
                                        onSelected:(value){
                                          if(value == 0){
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (context) =>
                                                            EditMember(DocID: document.id ,
                                                              oldName: data["name"],
                                                              oldDetail: data["details"],
                                                              oldUrl: data["image"],)
                                                    ));
                                          }else if(value == 1){
                                            FirebaseFirestore.instance.collection("members").doc(document.id).delete();
                                                    Navigator.of(context).pushNamed("ourteam");
                                          }
                                        },
                                      ) : SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

