import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required var email, required var password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if(ex.code == "user not found") {
        emit(LoginFailed());
      } else if (ex.code == "wrong password") {
        emit(LoginFailed());
      }
    } catch (e) {
      emit(LoginFailed());
    }
  }
}
