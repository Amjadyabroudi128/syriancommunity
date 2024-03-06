import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/padding.dart';

import '../../themes/colors.dart';
import '../../themes/fontSize.dart';
import '../../themes/font_weight_helper.dart';
import 'editCommunity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Community extends StatefulWidget {
  final document;

  const Community({Key? key, this.document}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final CollectionReference community =
  FirebaseFirestore.instance.collection('Community');
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.communityResources),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            padding(
              child: Center(
                child: user != null ? CustomButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed("addCommunity");
                    },
                    title: AppLocalizations.of(context)!.addDetails) : sizedBox(),
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
                          child: data["image"] != null ? Image.network(
                            data["image"],
                            height: MediaQuery.of(context).size.height * 0.40,
                          ) : SizedBox.shrink(),
                        ),
                      ),
                      Text(data["name"], style: TextStyles.font14green,),
                      sizedBox(height: 12,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: IntrinsicHeight(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                  Padding(
                                    padding:  EdgeInsets.all(14),
                                    child: Text(data["details"], style: TextStyle(fontSize: 17),),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 310, ),
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
                                                  EditCommunity(DocID: document.id ,
                                                    oldName: data["name"],
                                                    oldUrl: data["image"],
                                                    oldDetails: data["details"],)
                                              ));

                                        }else if(value == 1){
                                          FirebaseFirestore.instance.collection("Community").doc(document.id).delete();
                                          Navigator.of(context).pushNamed("community");
                                        }
                                      },
                                    ) : SizedBox(height: 42),
                                  ),
                              ],
                            ),
                            color: ColorManager.cardColor,
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
