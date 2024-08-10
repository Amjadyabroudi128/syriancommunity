import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/Screens/HomePage/AddHomePage.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/addEvent.dart';
import 'package:syrianadmin/components/constants.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import 'package:syrianadmin/enums.dart';
import '../../components/formatedData.dart';
import '../SideDrawer.dart';
import 'editHomePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => HomePage(),
  );
  final document;

  const HomePage({Key? key, this.document}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String appBarTitle = AppLocalizations.of(context)!.syrianCommunity;
    addHome() {
    String btnTitle = AppLocalizations.of(context)!.addThings;
    Color? btnClr = add;
      return addEvent(onPressed: (){
        Navigator.push(context, AddInfo.route());
      },
          title: btnTitle,
          color: btnClr);
    }
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: myIcons.drawer,
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(appBarTitle),
      ),
      drawer: SideDrawer(),
      body: padding(
        // padding: const EdgeInsets.all(15.0),
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: ListView(
            children: [
              Column(
                children: [
                  user != null ? addHome(): sizedBox(),
                   sizedBox(height: 6.h,),
                   Text(AppLocalizations.of(context)!.news),
                  sizedBox(height: 5.h,),
                  StreamBuilder(
                    stream: dbColl.time.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {

                        return Text(AppLocalizations.of(context)!.error);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return kLoading;
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return  SafeArea(
                          child: Center(
                           child: Column(
                             children: [
                               sizedBox(height: 200,),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox(
                            width: MediaQuery.of(context).size.width.w,
                            child: IntrinsicHeight(
                              child: Card(
                                child: padding(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(formattedDate(data["time" ],context), style: TextStyles.fontdate,),
                                        sizedBox(height: 6.h,),
                                        Text(data["name"] ?? SizedBox.shrink(), style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),),
                                      sizedBox(height: 6.h,),
                                      Text(data["details"] ?? SizedBox.shrink()),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 300),
                                        child: user != null ? MyPopUpMenu(
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem<myPop>(
                                                    value: myPop.edit,
                                                    child: Text(AppLocalizations.of(context)!.edit),
                                                  ),
                                                  PopupMenuItem<myPop>(
                                                    value: myPop.delete,
                                                    child: Text(AppLocalizations.of(context)!.delete, style: TextStyles.delete,),
                                                  ),
                                                ];
                                              },
                                              onSelected: (selectedPop) {
                                                if(selectedPop == myPop.edit) {
                                                  Navigator.of(context).push(
                                                      CupertinoPageRoute(
                                                          builder: (context) {
                                                            return
                                                              EditHome(DocID: document.id,
                                                                oldName: document["name"],
                                                                oldDetail: document["details"],
                                                                );
                                                              }
                                                              )
                                                            );
                                                } else if (selectedPop == myPop.delete) {
                                                  dbColl.myHome.doc(document.id).delete();
                                                  showSnackBar(context, AppLocalizations.of(context)!.deleted);
                                                }
                                                },
                                        ): SizedBox.shrink(),

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
        ),
      )
    );
  }
}
