import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/auth_cubit.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/SubmitButton.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/themes/fontSize.dart';

import '../themes/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String testEmail = "SussexCommunity@gmail.com";
  String testPassword = "Syria963";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is LoginSuccess)  {
      Navigator.of(context).pushNamed("homepage");
    } else if (state is LoginLoading) {

    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.loginAdmin),
             sizedBox(height: 19,),
            CustomTextForm(hinttext: AppLocalizations.of(context)!.email,),
            sizedBox(height: 15,),
            CustomTextForm(hinttext: AppLocalizations.of(context)!.password,),
            sizedBox(height: 20,),
             TextButton(
                onPressed: () async {
                  BlocProvider.of<AuthCubit>(context).login(email: testEmail, password: testPassword);
                },
                child:  Text(AppLocalizations.of(context)!.login,style: TextStyles.font20white
                ),
              ),
          ],
        ),
      ),
    );
  },
);
  }
}