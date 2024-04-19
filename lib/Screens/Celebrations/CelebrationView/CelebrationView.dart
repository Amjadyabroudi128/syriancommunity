import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Screens/Celebrations/Delete/delete_cubit.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/editCelebrations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/image.network.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/components/popUpMenu.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
import '../../../components/SubmitButton.dart';
class Celebrations extends StatelessWidget {
  final document;

   Celebrations({Key? key, this.document}) : super(key: key);

  final CollectionReference celebrations =
  FirebaseFirestore.instance.collection('Celebrations');
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return BlocConsumer<DeleteCubit, DeleteState>(
  listener: (context, state) {
    if (state is DeleteSuccess) {
      Navigator.of(context).pushReplacementNamed("celebrations");
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.celebrations),
      ),
      body:  SingleChildScrollView(
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: user != null ? CustomButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed("addcelebration");
                        },
                        title: AppLocalizations.of(context)!.addCelebration,color: ColorManager.addEdit,) : sizedBox(height: 15,),
                  ),
                  padding(child: Text(AppLocalizations.of(context)!.celebrations, style: TextStyles.font16green,)),
                  sizedBox(),
                  Container(
                    width: 400,
                    height: 100,
                    child: padding(
                      child: Card(
                        child: Text(AppLocalizations.of(context)!.join, style: TextStyles.font17,),
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
                                  sizedBox(height: 3,),
                                  // padding(child: Text(data["name"], style: TextStyles.font14green,)),
                                  user != null ? GestureDetector(
                                      child: Container(
                                        child: data["image"] != null? myImage(
                                          width: MediaQuery.of(context).size.width * 50,
                                          height: MediaQuery.of(context).size.height * 0.30,
                                          src: data["image"],
                                        ) : SizedBox.shrink(),
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
                                  ) :  Container(
                                     child: data["image"] != null ? myImage(
                                       width: MediaQuery.of(context).size.width,
                                       height: MediaQuery.of(context).size.height * 0.30,
                                       src: data["image"],
                                     ) : SizedBox.shrink(),
                                   ),

                                 SizedBox(
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
                                                        MaterialPageRoute(
                                                            builder: (context) => EditCelebration(
                                                                DocID: document.id,
                                                                oldName: data["name"],
                                                                oldDetail: data["details"],
                                                                oldUrl: data["image"])
                                                        ),
                                                      );
                                                    }else if(value == 1){
                                                      context.read<DeleteCubit>().delete(document.id);
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
  },
);
  }
}
