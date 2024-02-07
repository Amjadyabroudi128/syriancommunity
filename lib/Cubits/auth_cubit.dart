import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required var email, required var password}) async {
    emit(LoginLoading());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
    emit(LoginSuccess());
  }
}
