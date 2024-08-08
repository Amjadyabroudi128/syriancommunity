import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/constants.dart';
import 'package:syrianadmin/components/goBack.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import 'package:syrianadmin/enums.dart';
import 'EditTeam.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetOurTeam extends StatefulWidget {
  final document;
  const MeetOurTeam({@required this.document});

  @override
  State<MeetOurTeam> createState() => _MeetOurTeamState();
}

class _MeetOurTeamState extends State<MeetOurTeam> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String team = AppLocalizations.of(context)!.team;
    return Scaffold(
      appBar: AppBar(
        leading: goBack(
          onPressed: (){
            Navigator.of(context).pushNamed("homepage");
          },
        ),
        title: Text(team),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  padding(
                    child: user != null ? addMember() : sizedBox(),
                  ),
                  StreamBuilder(
                    stream: dbColl.members.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return wrong;
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return kLoading;
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return SafeArea(
                            child: Center(
                              child: Column(
                                children: [
                                  sizedBox(height: 200),
                                  kNothing
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
                                child: user != null ? Card(
                                  shape: const CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  child: data["image"] !=  null ? myImage(
                                    src: data["image"],
                                    height: 240,
                                    width: 240,
                                    fit: BoxFit.cover,
                                    onPressed: (){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) =>
                                                EditMember(DocID: document.id ,
                                                  oldName: data["name"],
                                                  oldDetail: data["details"],
                                                  oldUrl: data["image"],)
                                            ));
                                    },
                                  ) : SizedBox.shrink(),
                                ) :
                                Card(
                                  shape: const CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  child: data["image"] !=  null ? myImage(
                                    src: data["image"],
                                    height: 240,
                                    width: 240,
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
                                                  PopupMenuItem<myPop>(
                                                      value: myPop.edit,
                                                      child: Text(AppLocalizations.of(context)!.edit)
                                                  ),
                                                  PopupMenuItem<myPop>(
                                                    value: myPop.delete,
                                                    child: Text(AppLocalizations.of(context)!.delete, style: TextStyles.delete,),
                                                  ),
                                                ];
                                                },
                                              onSelected:(selectedPop){
                                                if(selectedPop == myPop.edit){
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) =>
                                                    EditMember(DocID: document.id ,
                                                      oldName: data["name"],
                                                      oldDetail: data["details"],
                                                      oldUrl: data["image"],)
                                            ));
                                   } else if(selectedPop == myPop.delete){
                                    dbColl.members.doc(document.id).delete();
                                    showSnackBar(context, AppLocalizations.of(context)!.deleted);
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
          ),
      ),
    );
  }
  addMember () {
    String kTitle = AppLocalizations.of(context)!.addThings;
    return CustomButton(
      onPressed: (){
        Navigator.of(context).pushNamed("addMember");
      },
      title: kTitle,
      color: add,
    );
  }
}


