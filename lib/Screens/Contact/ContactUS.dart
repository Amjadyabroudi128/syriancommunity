import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syrianadmin/Screens/Contact/Edit.dart';
import 'package:syrianadmin/components/ListTile.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syrianadmin/core/themes/colors.dart';

class ContactUs extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => ContactUs(),
  );
  final document;
  const ContactUs({@required this.document});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  addCustomIcon ()  {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          platform: TargetPlatform.android,
        ),
        myIcons.marker,
      mipmaps: true
    ).then((icon) {
      setState(() {
        markerIcon = icon ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("homepage");
            },
            icon: myIcons.goBack
        ),
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
                          ? addInfo()
                          : sizedBox(
                              height: 15,
                            )),
                  sizedBox(
                    height: 25,
                  ),
                  // Text(AppLocalizations.of(context)!.visitHere, style: TextStyles.font15,),
                  StreamBuilder<QuerySnapshot>(
                      stream: dbColl.contact.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
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
                                  Text(AppLocalizations.of(context)!.phoneContact, style: TextStyles.font20grey,),
                                  sizedBox(height: 10,),
                                  Card(
                                    child: Column(
                                      children: [
                                         MYlist(
                                            leading: myIcons.normalEmail,
                                            title: GestureDetector(
                                                child: Text(data["email"], style: TextStyles.emailLink),
                                              onTap: (){
                                                launchUrl(
                                                    Uri.parse("mailto:sussexsyriancommunity@gmail.com?subkect= send email&body= ")
                                                );
                                              },
                                            ),
                                          ),
                                        Divider(),
                                         MYlist(
                                            leading: myIcons.phone,
                                            title: GestureDetector(
                                                child: Text(data["phone"], style: TextStyles.font16green,),
                                              onTap: (){
                                                launchUrl(
                                                    Uri.parse("tel: ${data["phone"]}")
                                                );
                                              },
                                            ),
                                          ),


                                      ],
                                    ),
                                  ),
                                  sizedBox(
                                    height: 5,
                                  ),
                                  Text(AppLocalizations.of(context)!.location, style: TextStyles.font20grey,),
                                  sizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SelectableText(data["place"],),
                                            SelectableText(data["street name"],),
                                            SelectableText(data["post code"],),
                                            SelectableText(data["city"],),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  sizedBox(height: 10),
                                  Container(
                                      height: 300,
                                      width: 370,
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(50.82062318563144, -0.12208351759729541),
                                          zoom: 14,
                                        ),
                                        markers: {
                                          Marker(
                                              markerId: MarkerId("college"),
                                              position: LatLng(50.82062318563144, -0.12208351759729541),
                                              draggable: true,
                                              onDragEnd: (value) {
                                              },
                                            icon: markerIcon,
                                          ),
                                        },

                                      ),
                                    ),
                                  sizedBox(height: 10,),
                                  Text(AppLocalizations.of(context)!.facebook),
                                  sizedBox(height: 10,),
                                  faceBook(),
                                  sizedBox(height: 15,),
                                 user!= null ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(onPressed: (){
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
                                      },
                                        title: "${AppLocalizations.of(context)!.edit}"
                                            " ${AppLocalizations.of(context)!.thisPage}",
                                        color: ColorManager.addEdit,
                                      ),
                                      sizedBox(width: 12,),
                                      CustomButton(onPressed: () {
                                        dbColl.contact.doc(document.id).delete();
                                        ScaffoldMessenger.of(context).showSnackBar
                                          ( SnackBar(content: Text(AppLocalizations.of(context)!.deleted),));
                                      }, title: AppLocalizations.of(context)!.delete,
                                        color: ColorManager.delete,
                                      ),

                                    ],

                                  ) : SizedBox.shrink(),
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
  faceBook (){
   return  Card(
      child: MYlist(
        leading: IconButton(
          onPressed: () {
            launchUrl(Uri.parse(
                'https://www.facebook.com/groups/SyrianCommunityGroup'));},
          icon: myIcons.facebook
        ),
        title: Text("${AppLocalizations.of(context)!.visit} "
            "${AppLocalizations.of(context)!.facebook}"),
      ),
    );
  }
  addInfo () {
    return CustomButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed("addcontact");
      },
      title: AppLocalizations.of(context)!.addThings,
      color: ColorManager.addEdit,
    );
  }
}
