import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/auth_cubit/auth_cubit.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final testEmail = TextEditingController();
   final testPassword = TextEditingController();

   bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is LoginSuccess)  {
      Navigator.of(context).pushReplacementNamed("homepage");
      ScaffoldMessenger.of(context).showSnackBar
        ( SnackBar(content: Text(AppLocalizations.of(context)!.login),));
    } else if (state is LoginLoading) {

    }
  },
  builder: (context, state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.login),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.loginAdmin),
                 sizedBox(height: 19,),
                CustomTextForm(hinttext: AppLocalizations.of(context)!.email, myController: testEmail,),
                sizedBox(height: 15,),
                CustomTextForm(hinttext: AppLocalizations.of(context)!.password, obscureText: _isHidden, maxLines: 1,
                  myController: testPassword,
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _togglePasswordView();
                      });
                    },
                    icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off,
                      color: _isHidden ? ColorManager.delete : ColorManager.submit,
                    ),
                  ),
                ),
                sizedBox(height: 20,),
                 Container(
                   decoration: const BoxDecoration(
                     gradient: LinearGradient(
                       colors: [
                         Colors.lightBlueAccent,
                         Colors.blueAccent,
                         Colors.blueGrey
                       ],
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                     )
                   ),
                   child: loginButton()
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  loginButton () {
    return TextButton(
      onPressed: () async {
        await  BlocProvider.of<AuthCubit>(context).login(email: testEmail.text, password: testPassword.text);
      },
      child:  Text(AppLocalizations.of(context)!.login,style: TextStyles.font20white,

      ),
    );
  }
}