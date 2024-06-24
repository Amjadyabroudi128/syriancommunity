import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteInitial());
  final CollectionReference celebration = FirebaseFirestore.instance.collection("Celebrations");
  Future <void> delete(String DocID,) async {
    emit(DeleteLoading());
    try {
       celebration.doc(DocID).delete();
       emit(DeleteSuccess());
    } catch (e) {
      DeleteFailure(errMessage: "something is wrong ");
    }
  }
}
