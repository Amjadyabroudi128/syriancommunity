import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future login({required String email, required String password, required BuildContext context }  ) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailed(errMessage: AppLocalizations.of(context)!.wrongEmail));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailed(errMessage: AppLocalizations.of(context)!.wrongPassword));
      } else {
        emit(LoginFailed(errMessage: 'Authentication error: ${ex.message}'));
      }
    } catch (e) {
      emit(LoginFailed(errMessage: 'Something went wrong: ${e.toString()}'));
    }
  }

}
