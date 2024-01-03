import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetOurTeam extends StatelessWidget {
  const MeetOurTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Our Team"),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                    height: 40,
                    minWidth: 230,
                    color: Colors.grey,
                    child: Text("Add members +"),
                    onPressed: (){
                      Navigator.of(context).pushNamed("addMember");

                    },
                  ),
                ),

                Text("Meet our Teaam",
                  style: TextStyle(color: Color.fromARGB(255, 33, 173, 168),
                    fontSize: 18
            ),
                ),
                SizedBox(height: 9,),
                Text("Meet our  committee members, Ahmad Yabroudi (Chair) and Fathi Khalil (Treasurer), "
                    "Who work to represent the Community", style: TextStyle(fontSize: 17),),
                SizedBox(height: 12,),
                Text("We also work very closely with organisations in the city of Brighton and Hove. Meet Rachel Hughes, Assistant Headteacher at Brighton College, "
                    "who has been working in collaboration with our community, "
                    "and the team of volunteers at Brighton College.", style: TextStyle(fontSize: 17),),
                SizedBox(height: 12,),
                Text("we also have other Volunteers ", style: TextStyle(fontSize: 17),),
                SizedBox(height: 15,),
                // Row(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(bottom: 500), // Border width
                //       decoration: BoxDecoration(
                //           shape: BoxShape.circle),
                //       child: ClipOval(
                //         child: SizedBox.fromSize(
                //           size: Size.fromRadius(25), // Image radius
                //           child: Image.asset("images/ahmadyabroudi.jpg")
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 15,),
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 70),
                //       child: Column(
                //         children: [
                //           Text("AHMAD YABROUDI", style: TextStyle(color: Color.fromARGB(255, 33, 173, 168),),),
                //           SizedBox(height: 5,),
                //           Container(
                //             color: Colors.grey[300],
                //             width: 270,
                //             child: Text(
                //               "Ahmad is the elected Sussex Syrian Community representative, and oversees all projects."
                //                   "He is a former International Consultant for Education & Fairs, and a Syrian businessman."
                //                   "Since my arrival to Britain in 2013, my goal was to help Syrian refugees within the resettlement program approved by the British government and to provide them with assistance in all aspects of life to reach its achievement of full integration into British society, and my belief in the inevitability of achieving this goal was imperative to strive to create a social entity that includes all Syrian social strata."
                //                   "With the support and encouragement of Brighton and Hove City Council, the Syrian community was established in Sussex County with some Syrian friends and I have faith in working within a team that believes in spreading the Syrian cultural message to the community around us to our history and spreading the Syrian civilisation message, which is the true identity of every Syrian around the world and to achieve our goals."
                //                   "Through the implementation of the community’s goals to achieve full integration into the new society and achieve justice and equality, we set our goals to achieve this and work on it.",
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // )
                // this is just a test to see how the page will look like
              ],
        ),
          ),
      ),
    );
  }
}

