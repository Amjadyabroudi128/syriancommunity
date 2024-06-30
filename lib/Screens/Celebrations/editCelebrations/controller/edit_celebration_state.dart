part of 'edit_celebration_bloc.dart';

@immutable
sealed class EditCelebrationState {}

final class EditCelebrationInitial extends EditCelebrationState {}
class EditSuccess extends EditCelebrationState {}
class EditLoading extends EditCelebrationState {}
class EditFailure extends EditCelebrationState {
  final String errMessage;
  EditFailure ({required this.errMessage});
}