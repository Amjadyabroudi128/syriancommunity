part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}
class AddCelebration {
  final String name;
  final String details;
  AddCelebration ({required this.name, required this.details});
}