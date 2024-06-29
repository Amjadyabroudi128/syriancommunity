part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}
class addCelebration extends AddEvent{
  final String name;
  final String details;
  addCelebration ({required this.name, required this.details});
}