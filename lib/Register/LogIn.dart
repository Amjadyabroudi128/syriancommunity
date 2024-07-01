import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/classes/validate%20state.dart';
import 'package:syrianadmin/components/Sizedbox.dart';
import 'package:syrianadmin/components/TextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/components/snackBar.dart';
import 'package:syrianadmin/core/themes/colors.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';

import 'Bloc/auth_bloc.dart';
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
    String logIn = AppLocalizations.of(context)!.login;
     return ScreenUtilInit(
       minTextAdapt: true,
       splitScreenMode: true,
       child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(logIn),
          ),
            body:  Padding(
              padding: const EdgeInsets.all(7.0),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccess)  {
                    Navigator.of(context).pushReplacementNamed("homepage");
                    showSnackBar(context, AppLocalizations.of(context)!.login);
                  } if (state is LoginFailed) {
                    showSnackBar(context, state.errMessage);
                  }
                },
                child: Form(
                key: Validate.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.loginAdmin, style: TextStyles.loginAdmin,),
                     sizedBox(height: 14,),
                    CustomTextForm(
                      suffixIcon: testEmail.text.isEmpty? null :
                      IconButton(onPressed: testEmail.clear,
                        icon: myIcons.clear,),
                      myController: testEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: myIcons.email,
                      label: Text(AppLocalizations.of(context)!.email,),
                      validator: (value){
                        if (value == null || testEmail.text.isEmpty){
                          return AppLocalizations.of(context)!.email;
                        }
                        return null;
                      },
                    ),
                    sizedBox(height: 15,),
                    CustomTextForm(
                       obscureText: _isHidden, maxLines: 1,
                      myController: testPassword,
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                _togglePasswordView();
                               }
                              );
                              Future.delayed(Duration(seconds: 1), () {
                                if (mounted)
                                  setState(() {
                                    _togglePasswordView();
                                  });
                              });
                            },
                            icon: _isHidden ? myIcons.visible : myIcons.nonVisible,
                              color: _isHidden ? ColorManager.delete : ColorManager.submit,
                            ),
                         testPassword.text.isEmpty ? sizedBox() : IconButton(onPressed: testPassword.clear,
                            icon: myIcons.clear,)
                        ],
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      label: Text(AppLocalizations.of(context)!.password),
                      prefixIcon: myIcons.pass,
                      validator: (pass){
                         if (pass == null || testPassword.text.isEmpty){
                           return AppLocalizations.of(context)!.password;
                         }
                         return null;
                      },
                      ),
                    sizedBox(height: 20,),
                    (testEmail.text.isEmpty) || (testPassword.text.isEmpty) ? IntrinsicHeight(
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: loginButton(),
                      ),
                    ) :  ButtonContainer(),
                  ],
                ),
              ),
             ),
            ),
        ),
       ),
     );
  }

  IntrinsicHeight ButtonContainer() {
    return IntrinsicHeight(
                  child: Container(
                    width: 120,
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
        Validate.validating();
        BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: testEmail.text, password: testPassword.text));
      },
      child:  Text(AppLocalizations.of(context)!.login,style: TextStyles.font20white,
      ),
    );
  }
}