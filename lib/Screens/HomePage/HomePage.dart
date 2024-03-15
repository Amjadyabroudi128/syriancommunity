import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/themes/colors.dart';
import '../../components/formatedData.dart';
import '../../themes/fontSize.dart';
import '../SideDrawer.dart';
import 'editHomePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomePage extends StatefulWidget {
  final document;

  const HomePage({Key? key, this.document}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var home =
    FirebaseFirestore.instance.collection('home').orderBy("time", descending: true);
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
        title: Text(AppLocalizations.of(context)!.syrianCommunity),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                user != null ? CustomButton(onPressed: (){
                  Navigator.of(context).pushNamed("addInfo");
                }, title: AppLocalizations.of(context)!.addThings, color: ColorManager.addEdit) : sizedBox(),
                sizedBox(),
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
                      return  SafeArea(
                        child: Center(
                         child: Column(
                           children: [
                             sizedBox(height: 200,),
                             Text("nothing to see here yet :( ", style: TextStyles.font20grey,)
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width ,
                          child: IntrinsicHeight(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: padding(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(formattedDate(data["time" ],context), style: TextStyles.fontdate,),
                                      sizedBox(height: 6,),
                                      Text(data["name"]),
                                    sizedBox(height: 6,),
                                    Text(data["details"]),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 300),
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
                                          onSelected: (value) {
                                            if(value == 0) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return
                                                          EditHome(DocID: document.id,
                                                            oldName: document["name"],
                                                            oldDetail: document["details"],
                                                            );
                                                          }
                                                          )
                                                        );
                                            } else if (value == 1) {
                                              FirebaseFirestore.instance.collection("home").doc(document.id).delete();
                                            }
                                          },
                                          iconSize: 30): SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
