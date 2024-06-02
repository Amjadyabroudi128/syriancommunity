import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/auth_cubit/auth_cubit.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   late final testEmail = TextEditingController()..addListener(() {
     setState(() {
     });
   });
  late final testPassword = TextEditingController()..addListener(() {
    setState(() {
    });
  });
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
    String logIn = AppLocalizations.of(context)!.login;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(logIn),
        ),
          body:  Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.loginAdmin),
                 sizedBox(height: 19,),
                CustomTextForm(
                  myController: testEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: myIcons.email,
                  label: Text(AppLocalizations.of(context)!.email),
                ),
                sizedBox(height: 15,),
                CustomTextForm(
                   obscureText: _isHidden, maxLines: 1,
                  myController: testPassword,
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _togglePasswordView();
                      });
                    },
                    icon: _isHidden ? myIcons.visible : myIcons.nonVisible,
                      color: _isHidden ? ColorManager.delete : ColorManager.submit,
                    ),
                  keyboardType: TextInputType.visiblePassword,
                  label: Text(AppLocalizations.of(context)!.password),
                  prefixIcon: myIcons.pass,
                  ),
                sizedBox(height: 20,),
                (testEmail.text.isEmpty) || (testPassword.text.isEmpty) ? Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: loginButton(),
                ) :  Container(
                    decoration:  BoxDecoration(
                        gradient:  LinearGradient(
                          colors: ColorManager.LoginButton,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: loginButton()
                ),
              ],
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