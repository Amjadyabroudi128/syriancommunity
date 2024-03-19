import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/themes/colors.dart';
import 'package:syrianadmin/themes/font_weight_helper.dart';

import '../../components/SubmitButton.dart';
import '../../themes/fontSize.dart';
class Celebrations extends StatelessWidget {
  final document;

  const Celebrations({Key? key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.celebrations),
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
                      title: AppLocalizations.of(context)!.addCelebration,color: ColorManager.addEdit,) : sizedBox(height: 15,),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(AppLocalizations.of(context)!.celebrations, style: TextStyles.font16green,),
                ),
                sizedBox(),
                Container(
                  width: 400,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: ColorManager.cardColor,
                      child: padding(
                        child: Text(AppLocalizations.of(context)!.join, style: TextStyle(fontSize: 16),),
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
                              sizedBox(height: 200,),
                              Text("nothing to see here ", style: TextStyles.font20grey,)
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
                                padding:  EdgeInsets.only(bottom: 5, top: 10),
                                child: Center(child: Text(data["name"], style: TextStyles.font14green)),
                              ),
                             user != null ? GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                      child: data["image"] != null ? Image.network(
                                        data["image"],
                                        height: MediaQuery.of(context).size.height * 0.40,
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
                               padding: const EdgeInsets.all(1.0),
                               child: Container(
                                 child: data["image"] != null ? Image.network(
                                   data["image"],
                                   height: MediaQuery.of(context).size.height * 0.40,
                                   width: MediaQuery.of(context).size.width,
                                   // fit: BoxFit.cover,
                                 ) : SizedBox.shrink(),
                               ),
                             ),
                             SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: IntrinsicHeight(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),

                                    child:  Column(
                                      children: [
                                        padding(
                                          child: Text(data["details"], style: TextStyles.font17,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 300),
                                          child: user != null ? PopupMenuButton(
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
                                          ) :  SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

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
