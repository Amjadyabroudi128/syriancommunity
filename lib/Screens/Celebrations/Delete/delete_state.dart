part of 'delete_cubit.dart';

@immutable
abstract class DeleteState {}

 class DeleteInitial extends DeleteState {}
 class DeleteSuccess extends DeleteState {}
class  DeleteFailure extends DeleteState {
  final String errMessage;
  DeleteFailure({required this.errMessage});
}