import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("homepage");
            },
            icon: myIcons.goBack),
        title: Text(AppLocalizations.of(context)!.communityResources),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              padding(
                child: Center(
                  child: user != null ? addThings(): sizedBox(),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          padding(
                            child: user != null ? GestureDetector(
                              child: Card(
                                child: data["image"] != null ? myImage(
                                  src: data["image"],
                                  height: MediaQuery.of(context).size.height * 0.40,
                                ) : SizedBox.shrink(),
                              ),
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        EditCommunity(DocID: document.id ,
                                          oldName: data["name"],
                                          oldUrl: data["image"],
                                          oldDetails: data["details"],)
                                    ));
                              },
                            ) : Card(
                              child: data["image"] != null ? myImage(
                                src: data["image"],
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
                                child: Column(
                                  children: [
                                      padding(
                                        child: Text(data["details"], style: TextStyles.font17,),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 310, ),
                                        child: user != null ? MyPopUpMenu(
                                          itemBuilder: (context) {
                                          return [
                                            PopupMenuItem<int>(
                                              value: 0,
                                              child: Text(AppLocalizations.of(context)!.edit),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 1,
                                              child: Text(AppLocalizations.of(context)!.delete, style: TextStyles.delete,),
                                            ),
                                          ];
                                          },
                                            onSelected:(value){
                                              if(value == 0){
                                                Navigator.of(context).push(
                                                    CupertinoPageRoute(builder: (context) =>
                                                        EditCommunity(DocID: document.id ,
                                                          oldName: data["name"],
                                                          oldUrl: data["image"],
                                                          oldDetails: data["details"],)
                                                    ));

                                              }else if(value == 1){
                                                community.doc(document.id).delete();
                                                ScaffoldMessenger.of(context).showSnackBar
                                                  ( SnackBar(content: Text(AppLocalizations.of(context)!.deleted)));
                                              }
                                            },
                                          popUpAnimationStyle: AnimationStyle(
                                              duration: Duration(milliseconds: 400)
                                          ),
                                        ) : sizedBox(height: 40,),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
  addThings () {
    return CustomButton(
      onPressed: (){
        Navigator.of(context).pushNamed("addCommunity");
      },
      title: AppLocalizations.of(context)!.addDetails, color: ColorManager.addEdit,);
  }
}
