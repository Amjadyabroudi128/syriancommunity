import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Future login({required var email, required var password}) async {
  //   emit(LoginLoading());
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     emit(LoginSuccess());
  //   } on FirebaseAuthException catch (ex) {
  //     if(ex.code == "user not found") {
  //       emit(LoginFailed(errMessage: 'wrong email'));
  //     } else if (ex.code == "wrong password") {
  //       emit(LoginFailed(errMessage: 'wrong password'));
  //     }
  //   } catch (e) {
  //     emit(LoginFailed(errMessage: 'something not right '));
  //   }
  // }
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailed(errMessage: 'Wrong email'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailed(errMessage: 'Wrong password'));
      } else {
        emit(LoginFailed(errMessage: 'Authentication error: ${ex.message}'));
      }
    } catch (e) {
      emit(LoginFailed(errMessage: 'Something went wrong: ${e.toString()}'));
    }
  }

}
