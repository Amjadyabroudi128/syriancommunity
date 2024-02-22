import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations.dart';

import '../../components/SubmitButton.dart';
class Celebrations extends StatelessWidget {
  final document;

  const Celebrations({Key? key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Celebrations"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: user != null ? CustomButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed("addcelebration");
                      },
                      title: "Add celebrations +") : SizedBox(height: 15,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Celebrations ", style: TextStyle(
                      color: Color.fromARGB(255, 33, 173, 168),
                      fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  width: 400,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("join us in our celebrations to bring the community together  throughout the year",
                        style: TextStyle(fontSize: 16),),
                      ),

                    ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Celebrations").snapshots(),
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
                              Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(data["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
                                  color: Color.fromARGB(255, 33, 173, 168),),),
                              ),
                             user != null ? GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      child: data["image"] != null ? Image.network(
                                        data["image"],
                                        height: MediaQuery.of(context).size.height * 0.40,
                                        // fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width,
                                      ) : SizedBox.shrink(),
                                    ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditCelebration(
                                                DocID: document.id,
                                                oldName: data["name"],
                                                oldDetail: data["details"],
                                                oldUrl: data["image"])
                                    ),
                                  );
                                },
                              ) : Padding(
                               padding: const EdgeInsets.all(4.0),
                               child: Container(
                                 child: data["image"] != null ? Image.network(
                                   data["image"],
                                   height: MediaQuery.of(context).size.height * 0.40,
                                   // fit: BoxFit.cover,
                                   width: MediaQuery.of(context).size.width,
                                 ) : SizedBox.shrink(),
                               ),
                             ),
                              SizedBox(height: 7,),
                             Container(
                                child: IntrinsicHeight(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    color: Colors.grey[300],
                                    elevation: 0,
                                    child:  Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(data["details"], style: TextStyle(fontSize: 17),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 300),
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
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditCelebration(
                                                              DocID: document.id,
                                                              oldName: data["name"],
                                                              oldDetail: data["details"],
                                                              oldUrl: data["image"])
                                                  ),
                                                );
                                              }else if(value == 1){
                                                FirebaseFirestore.instance.collection("Celebrations").doc(document.id).delete();
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => Celebrations()
                                                  )
                                                );
                                              }
                                            },
                                          ) : SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,

                              )
                            ]
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
      ),
    );
  }
}
