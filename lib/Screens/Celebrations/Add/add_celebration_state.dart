part of 'add_celebration_cubit.dart';

@immutable
abstract class AddCelebrationState {}

 class AddCelebrationInitial extends AddCelebrationState {}

 class AddLoading extends AddCelebrationState {}
 class AddSuccess extends AddCelebrationState {}
class AddFailure extends AddCelebrationState {
final String errMessage;
 AddFailure ({required this.errMessage});
}
