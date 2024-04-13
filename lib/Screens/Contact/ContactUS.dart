import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syrianadmin/Screens/Contact/Edit.dart';
import 'package:syrianadmin/components/ListTile.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/Container.dart';
import 'package:syrianadmin/core/themes/colors.dart';

class ContactUs extends StatefulWidget {
  final document;
  const ContactUs({@required this.document});

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
            child: padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: user != null
                          ? CustomButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("addcontact");
                              },
                              title: AppLocalizations.of(context)!.addThings,
                              color: ColorManager.addEdit,
                            )
                          : sizedBox(
                              height: 15,
                            )),
                  sizedBox(
                    height: 25,
                  ),
                  // Text(AppLocalizations.of(context)!.visitHere, style: TextStyles.font15,),
                  StreamBuilder<QuerySnapshot>(
                      stream: contact.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        return ListView(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return padding(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.location),
                                  Card(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        MYlist(
                                          leading: Icon(
                                            Icons.place
                                          ),
                                          title: Text(data["place"], style: TextStyles.ListTile,),
                                        ),
                                        Divider(),
                                        MYlist(
                                          leading: Icon(
                                              Icons.add_road
                                          ),
                                          title: Text(data["street name"], style: TextStyles.ListTile,),
                                        ),
                                        Divider(),
                                         Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Text("Post code", style: TextStyle(fontSize: 18),),
                                              ),
                                              sizedBox(width: 10,),
                                              Text(data["post code"], style: TextStyle(fontSize: 15),),

                                            ],
                                           mainAxisAlignment: MainAxisAlignment.start,
                                          ),
                                        Divider(),
                                        MYlist(
                                          leading: Icon(
                                              Icons.location_city,
                                          ),
                                          title: Text(data["city"], style: TextStyles.ListTile,),
                                        ),

                                      ],
                                    ),
                                  ),
                                  sizedBox(height: 10),
                                  Center(
                                    child: Containers.location,
                                  ),
                                  Text(AppLocalizations.of(context)!.phoneContact),
                                  Card(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          child: MYlist(
                                            leading: Icon(
                                              Icons.email
                                            ),
                                            title: Text(data["email"], style: TextStyles.emailLink),
                                          ),
                                          onTap: (){
                                            launchUrl(
                                                Uri.parse("mailto:sussexsyriancommunity@gmail.com?subkect= send email&body= ")
                                            );
                                          },
                                        ),
                                        Divider(),
                                        GestureDetector(
                                          child: MYlist(
                                            leading: Icon(Icons.phone),
                                            title: Text(data["phone"], style: TextStyles.ListTile,),
                                          ),
                                          onTap: (){
                                            launchUrl(
                                              Uri.parse("tel: +44 7535260379")
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 300),
                                          child: user != null ? MyPopUpMenu(
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(value: 0, child: Text(AppLocalizations.of(context)!.edit),),
                                                  PopupMenuItem(value: 1, child: Text(AppLocalizations.of(context)!.delete, style: TextStyles.delete,),)
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
                                              }, icon: Icon(CupertinoIcons.ellipsis),
                                              popUpAnimationStyle: AnimationStyle(
                                                  duration: Duration(milliseconds: 400),
                                              ),
                                          ) : SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                    // child:
                                  ),
                                  sizedBox(
                                    height: 5,
                                  ),
                                  sizedBox(
                                    height: 7,
                                  ),
                                  Text(AppLocalizations.of(context)!.facebook),
                                  Card(
                                    child: MYlist(
                                      leading: IconButton(
                                        onPressed: () {
                                          launchUrl(Uri.parse(
                                              'https://www.facebook.com/groups/SyrianCommunityGroup'));},
                                        icon: Icon(
                                          Icons.facebook,
                                          color: ColorManager.fbColor,
                                          size: 38,
                                        ),
                                      ),
                                      title: Text("${AppLocalizations.of(context)!.visit} "
                                          "${AppLocalizations.of(context)!.facebook}"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
