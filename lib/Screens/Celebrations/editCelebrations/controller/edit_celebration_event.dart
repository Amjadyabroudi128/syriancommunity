part of 'edit_celebration_bloc.dart';

@immutable
sealed class EditCelebrationEvent {}

class editCelebration extends EditCelebrationEvent{
  final String DocID;
  final Map<String, dynamic> newData;
  editCelebration({required this.DocID, required this.newData});
}