import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial()) {
    on<DeleteEvent>((event, emit) {
      if (event is DeleteCelebration) {
        emit(DeleteLoading());
        try {
          dbColl.celebration.doc(event.DocID).delete();
          emit(DeleteSuccess());
        } catch (e) {
          DeleteFailure(errMessage: "something is wrong ");
        }
      }
    });
  }
}
