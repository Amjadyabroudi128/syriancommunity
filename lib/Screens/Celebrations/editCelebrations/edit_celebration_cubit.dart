import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_celebration_state.dart';

class EditCelebrationCubit extends Cubit<EditCelebrationState> {
  EditCelebrationCubit() : super(EditCelebrationInitial());

  final CollectionReference celebration = FirebaseFirestore.instance.collection("Celebrations");

  Future <void> EditCelebration(String DocID, Map<String, dynamic> newData) async {
    await celebration.doc(DocID).update(newData);
    emit(EditSuccess());
  }
}
