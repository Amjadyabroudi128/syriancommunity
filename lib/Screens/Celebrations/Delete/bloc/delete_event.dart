part of 'delete_bloc.dart';

@immutable
sealed class DeleteEvent {}
class DeleteCelebration extends DeleteEvent {
  final String DocID;
  DeleteCelebration ({required this.DocID});
}