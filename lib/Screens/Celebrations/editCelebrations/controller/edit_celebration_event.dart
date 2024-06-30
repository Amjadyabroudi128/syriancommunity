part of 'edit_celebration_bloc.dart';

@immutable
sealed class EditCelebrationEvent {}

class EditCelebration extends EditCelebrationEvent{
  final String DocID;
  final Map<String, dynamic> newData;
  EditCelebration({required this.DocID, required this.newData});
}