part of 'delete_bloc.dart';

@immutable
sealed class DeleteState {}

final class DeleteInitial extends DeleteState {}
class DeleteLoading extends DeleteState {}
class DeleteSuccess extends DeleteState {}
class  DeleteFailure extends DeleteState {
  final String errMessage;
  DeleteFailure({required this.errMessage});
}