import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial()) {
    final CollectionReference celebration = FirebaseFirestore.instance.collection("Celebrations");
    on<DeleteEvent>((event, emit) {
      if (event is DeleteCelebration) {
        emit(DeleteLoading());
        try {
          celebration.doc(event.DocID).delete();
          emit(DeleteSuccess());
        } catch (e) {
          DeleteFailure(errMessage: "something is wrong ");
        }
      }
    });
  }
}
