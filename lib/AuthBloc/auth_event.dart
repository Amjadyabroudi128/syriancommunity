part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent{
  String testEmail;
  String testPassword;
  LoginEvent({required this.testEmail, required this.testPassword});
}