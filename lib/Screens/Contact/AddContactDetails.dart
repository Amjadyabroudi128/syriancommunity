import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/padding.dart';
import 'package:syrianadmin/core/themes/colors.dart';
class AddContactDetails extends StatefulWidget {
  const AddContactDetails({Key? key}) : super(key: key);

  @override
  State<AddContactDetails> createState() => _AddContactDetailsState();
}

class _AddContactDetailsState extends State<AddContactDetails> {

  late final TextEditingController place = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController road = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController city = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController postcode = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController email = TextEditingController()..addListener(() {
    setState(() {
    });
  });
  late  TextEditingController phone = TextEditingController()..addListener(() {
    setState(() {
    });
  });


  final CollectionReference contact =
  FirebaseFirestore.instance.collection('contact');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDetails),
        ),
      body: padding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // sizedBox(height: 10,),
              padding(child: Text(AppLocalizations.of(context)!.place)),
              sizedBox(height: 8,),
              CustomTextForm(hinttext: "e.g : Brighton college", myController: place,
                  suffixIcon: IconButton(onPressed: place.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              sizedBox(),
              padding(child: Text(AppLocalizations.of(context)!.streetName)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: Eastern Road",  myController: road,
                  suffixIcon: IconButton(onPressed: road.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.city)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: Brighton", myController: city,
                  suffixIcon: IconButton(onPressed: city.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.postCode)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: "e.g: BN2 OAL", myController: postcode,
                  suffixIcon: IconButton(onPressed: postcode.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.email)),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.email, myController: email,
                  suffixIcon: IconButton(onPressed: email.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              padding(child: Text(AppLocalizations.of(context)!.phone),),
              sizedBox(height: 7,),
              CustomTextForm(hinttext: AppLocalizations.of(context)!.phone, myController: phone,
                  suffixIcon: IconButton(onPressed: phone.clear, icon: Icon(Icons.clear), color: Colors.black,)
              ),
              sizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  submitButton(),
                  sizedBox(width: 15,),
                  cancelButton()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void clearText() {
    place.clear();
    road.clear();
    city.clear();
    postcode.clear();
    email.clear();
  }
  cancelButton() {
    return CustomButton(
      onPressed: (){
        Navigator.pop(context);
      },
      title: AppLocalizations.of(context)!.cancel,
      color: ColorManager.delete,
    );
  }
  submitButton() {
    return CustomButton(
      onPressed: ()async {
        await contact.doc().set({
          "place" : place.text,
          "street name" : road.text,
          "city" : city.text,
          "post code" : postcode.text,
          "email" : email.text,
          "phone" : phone.text
        });
        Navigator.of(context).pop();
      },
      title: AppLocalizations.of(context)!.submit, color: ColorManager.submit,
    );
  }

}
