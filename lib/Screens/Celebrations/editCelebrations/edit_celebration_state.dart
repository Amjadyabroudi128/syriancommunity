part of 'edit_celebration_cubit.dart';

@immutable
abstract class EditCelebrationState {}

 class EditCelebrationInitial extends EditCelebrationState {}
 class EditSuccess extends EditCelebrationState {}
 class EditLoading extends EditCelebrationState {}
 class EditFailure extends EditCelebrationState {
 final String errMessage;
 EditFailure ({required this.errMessage});
 }
