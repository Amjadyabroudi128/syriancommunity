import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit, ) async {
      if (event is LoginEvent) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailed(errMessage: "wrong Email"));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailed(errMessage: "Wrong Password"));
          } else {
            emit(LoginFailed(errMessage: 'Authentication error: ${ex.message}'));
          }
        } catch (e) {
          emit(LoginFailed(errMessage: 'Something went wrong: ${e.toString()}'));
        }
      }
    });
  }
}
