part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


final class LoginLoadning extends AuthState{}

final class LoginSuccess extends AuthState {}
