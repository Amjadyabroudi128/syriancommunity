import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/classes/pickImage.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/themes/colors.dart';
import 'package:syrianadmin/themes/fontSize.dart';
import 'EditTeam.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context)!.team),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            padding(
              child: user != null ? CustomButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("addMember");
                },
                title: AppLocalizations.of(context)!.addThings,
                color: ColorManager.addEdit,
              ) : sizedBox(),
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
                            sizedBox(height: 200),
                            Text("nothing to see here yet", style: TextStyles.font20grey,)
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
                              child: data["image"] !=  null ? myImage(
                                src: data["image"],
                                height: 240,
                                width: 240,
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
                          ) :
                          Card(
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
                          Text(data["name"], style: TextStyles.font14green,),
                          sizedBox(height: 12,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: IntrinsicHeight(
                              child: Card(
                                child: Column(
                                  children: [
                                    padding(child: Text(data["details"], style: TextStyles.font17,) ,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 310),
                                      child: user != null ? MyPopUpMenu(
                                        itemBuilder: (context){
                                          return [
                                            PopupMenuItem<int>(
                                                value: 0,
                                                child: Text(AppLocalizations.of(context)!.edit)
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
                                          MaterialPageRoute(builder: (context) =>
                                              EditMember(DocID: document.id ,
                                                oldName: data["name"],
                                                oldDetail: data["details"],
                                                oldUrl: data["image"],)
                                      ));
                             } else if(value == 1){
                              members.doc(document.id).delete();
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

