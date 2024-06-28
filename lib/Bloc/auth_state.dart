part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFailed extends AuthState {
  final String errMessage;
  LoginFailed ({required this.errMessage});
}