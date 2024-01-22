import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/SubmitButton.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final CollectionReference community =
  FirebaseFirestore.instance.collection('community');
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
            ),
            StreamBuilder(
              stream: community.snapshots(),
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
                          child: Image.network(
                            data["image"],
                            height: MediaQuery.of(context).size.height * 0.40,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Text(data["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
                        color: Color.fromARGB(255, 33, 173, 168),),),
                      SizedBox(height: 12,),
                      Container(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
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
                              ),
                            ],
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
