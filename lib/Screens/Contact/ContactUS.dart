import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Contact/Edit.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/Container.dart';
import '../../themes/colors.dart';
import '../../themes/fontSize.dart';
class ContactUs extends StatefulWidget {
  final document;
  const ContactUs({ @required this.document});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final CollectionReference contact =
  FirebaseFirestore.instance.collection('contact');
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.contact),
      ),
            body: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: user != null ? CustomButton(
                              onPressed: (){
                                Navigator.of(context).pushNamed("addcontact");
                              },
                              title: AppLocalizations.of(context)!.addThings, color: ColorManager.addEdit,) : sizedBox(height: 15,)
                        ),
                        sizedBox(height: 25,),
                        Text(AppLocalizations.of(context)!.visitHere, style: TextStyles.font15,),
                        StreamBuilder <QuerySnapshot>(
                          stream: contact.snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              return 
                                ListView(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    return padding(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: IntrinsicWidth(
                                              child: Card(
                                                child: Padding(
                                                  padding: EdgeInsets.all(12),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                              Text(AppLocalizations.of(context)!.location),
                                                              sizedBox(height: 5,),
                                                              Text(data["place"]),
                                                              sizedBox(height: 5,),
                                                              Text(data["street name"]),
                                                              sizedBox(height: 5,),
                                                              Text(data["city"]),
                                                              sizedBox(height: 5,),
                                                              Text(data["post code"]),

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
                                                                  MaterialPageRoute(builder: (context) =>
                                                                      EditDetails(DocID: document.id,
                                                                        oldPlace: data["place"],
                                                                        oldRoad: data["street name"],
                                                                        oldCity: data["city"],
                                                                        oldEmail: data["email"],
                                                                        oldPHone: data["phone"],
                                                                        oldPostCode: data["post code"],)));
                                                            }else if(value == 1){
                                                              FirebaseFirestore.instance.collection("contact").doc(document.id).delete();
                                                              Navigator.of(context).pushNamed("contactus");
                                                            }
                                                          },

                                                        ) : SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          sizedBox(),
                                          Text(AppLocalizations.of(context)!.phoneContact, style: TextStyles.font15,),
                                          sizedBox(),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Card(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  padding(child: Row(
                                                    children: [
                                                      Text(AppLocalizations.of(context)!.email),
                                                            sizedBox(width: 3,),
                                                            SelectableText(data["email"])
                                                    ],
                                                  )),
                                                  sizedBox(height: 10,),
                                                  padding(
                                                    child: Row(
                                                      children: [
                                                              Text(AppLocalizations.of(context)!.phone),
                                                              sizedBox(width: 3,),
                                                              SelectableText(data["phone"])
                                                      ],

                                                    ),
                                                  ),
                                                  sizedBox(),
                                                  padding(
                                                    child: Row(
                                                      children: [
                                                        Text("${AppLocalizations.of(context)!.visit} " "${AppLocalizations.of(context)!.facebook}"),
                                                        IconButton(
                                                          onPressed: (){
                                                            launchUrl(Uri.parse('https://www.facebook.com/groups/SyrianCommunityGroup'));
                                                          },
                                                          icon: Icon(Icons.facebook, color: ColorManager.fbColor),
                                                        )
                                                      ],

                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 310),
                                                    child: user != null ? MyPopUpMenu(
                                                        itemBuilder: (context) {
                                                          return [
                                                            PopupMenuItem(value: 0, child: Text(AppLocalizations.of(context)!.edit),),
                                                            PopupMenuItem(value: 1, child: Text(AppLocalizations.of(context)!.delete),)
                                                          ];
                                                        },
                                                        onSelected: (value) {
                                                          if (value == 0) {
                                                            Navigator.of(context).push(
                                                              CupertinoPageRoute(
                                                                builder: (context) =>
                                                                    EditDetails(DocID: document.id,
                                                                      oldPlace: data["place"],
                                                                      oldRoad: data["street name"],
                                                                      oldCity: data["city"],
                                                                      oldEmail: data["email"],
                                                                      oldPHone: data["phone"],
                                                                      oldPostCode: data["post code"],)));
                                                          } else if (value == 1) {
                                                            contact.doc(document.id).delete();
                                                            Navigator.of(context).pushNamed("contactus");
                                                          }
                                                        }): SizedBox.shrink(),

                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );

                                  }).toList(),
                                );
                          }
                        ),
                        Text(AppLocalizations.of(context)!.location),
                        sizedBox(),
                        Center(
                          child: Containers.location,
                        )
                      ],
                    ),

                  ),
                ),
              ),
            ),

    );
  }
}
