import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../SideDrawer.dart';
import 'editHomePage.dart';

class HomePage extends StatefulWidget {
  final document;

  const HomePage({Key? key, this.document}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formattedDate(timeStamp){
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('yMMMEd').format(dateFromTimeStamp);
  }
  @override
  Widget build(BuildContext context) {
    final CollectionReference home =
    FirebaseFirestore.instance.collection('home');

    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.list),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        toolbarHeight: 70,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("Syrian Community"),
        ),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      drawer: SideDrawer(),
      // i prefer the drawer to the DropDownMenu
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
              user != null ?  MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  height: 40,
                  minWidth: 230,
                  color: Colors.grey,
                  child: Text("Add things +"),
                  onPressed: (){
                    Navigator.of(context).pushNamed("addInfo");
                  },
                ) : SizedBox(),
                SizedBox(height: 12,),
                Text("here you will see the latest news for the Community"),
                StreamBuilder(
                  stream: home.snapshots(),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width ,
                          child: IntrinsicHeight(
                            child: Card(
                              color: Colors.grey[300],
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(formattedDate(data["time"]), style: TextStyle(color: Colors.grey),),
                                      SizedBox(height: 6,),
                                      Text(data["name"]),
                                    SizedBox(height: 6,),
                                    Text(data["details"]),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 300),
                                      child: user != null ?  PopupMenuButton(
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
                                              MaterialPageRoute(
                                              builder: (context) {
                                                return
                                                  EditHome(DocID: document.id,
                                                    oldName: data["name"],
                                                    oldDetail: data["details"],
                                                );
                                              }
                                              )
                                            );
                                          }else if(value == 1){
                                            FirebaseFirestore.instance.collection("home").doc(document.id).delete();
                                          }
                                        },
                                      ) : SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                    },
                      ).toList(),
                    )
                    );
                  },
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
