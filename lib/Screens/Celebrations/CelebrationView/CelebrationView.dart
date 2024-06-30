import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Screens/Celebrations/Delete/bloc/delete_bloc.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/screen/editCelebrations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import 'package:syrianadmin/enums.dart';
import '../../../components/SubmitButton.dart';
class Celebrations extends StatefulWidget {
  final document;

   Celebrations({Key? key, this.document}) : super(key: key);

  @override
  State<Celebrations> createState() => _CelebrationsState();
}

class _CelebrationsState extends State<Celebrations> {
  final CollectionReference celebrations =
  FirebaseFirestore.instance.collection('Celebrations');
  @override
  Widget build(BuildContext context) {
    String title = AppLocalizations.of(context)!.celebrations;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: goBack(),
        title: Text(title),
      ),
      body:  ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: user != null ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: addCelebration(),
                      ) : sizedBox(height: 15,),
                    ),
                    padding(child: Text(AppLocalizations.of(context)!.celebrations, style: TextStyles.font16green,)),
                    sizedBox(),
                    IntrinsicHeight(
                      child: padding(
                        child: Card(
                          child: padding(
                            child: Text(AppLocalizations.of(context)!.join, style: TextStyles.font17,),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: celebrations.snapshots(),
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
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data["name"], style: TextStyles.font14green,),
                                    sizedBox(height: 5,),
                                    user != null ? Container(
                                      child: data["image"] != null? myImage(
                                        onPressed: () {
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
                                        width: MediaQuery.of(context).size.width * 50,
                                        height: MediaQuery.of(context).size.height * 0.30,
                                        src: data["image"],

                                      ) : SizedBox.shrink(),
                                      ) :  Container(
                                       child: data["image"] != null ? myImage(
                                         width: MediaQuery.of(context).size.width,
                                         height: MediaQuery.of(context).size.height * 0.30,
                                         src: data["image"],
                                       ) : SizedBox.shrink(),
                                     ),

                                   BlocListener<DeleteBloc, DeleteState>(
                                     listener: (context, state) {
                                        if (state is DeleteSuccess) {
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          showSnackBar(context, AppLocalizations.of(context)!.deleted);
                                        } else if (state is DeleteFailure) {
                                          state.errMessage;
                                        }
                                        },
                                        child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: IntrinsicHeight(
                                        child: Card(
                                          child:  Column(
                                            children: [
                                              padding(
                                                child: Text(data["details"], style: TextStyles.font17,),
                                              ),
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
                                                  onSelected:(selectedValue){
                                                      if(selectedValue == myPop.edit){
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) => EditCelebration(
                                                                  DocID: document.id,
                                                                  oldName: data["name"],
                                                                  oldDetail: data["details"],
                                                                  oldUrl: data["image"])
                                                          ),
                                                        );
                                                      }else if(selectedValue == myPop.delete){
                                                        BlocProvider.of<DeleteBloc>(context).add(
                                                            DeleteCelebration(DocID: document.id)
                                                        );
                                                      }
                                                      },
                                                  popUpAnimationStyle: AnimationStyle(
                                                      duration: Duration(milliseconds: 400)
                                                  ),
                                                ) :  SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ),
                                   ),
                                  ]
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
        ),
    );
  }
  addCelebration () {
    return  CustomButton(
      onPressed: (){
        Navigator.of(context).pushNamed("addcelebration");
      },
      title: AppLocalizations.of(context)!.addCelebration,color: ColorManager.addEdit,);
  }
  goBack () {
   return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed("homepage");
        },
        icon: myIcons.goBack);
  }

}



