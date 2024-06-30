import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syrianadmin/core/FirebaseCollections.dart';

part 'edit_celebration_event.dart';
part 'edit_celebration_state.dart';

class EditCelebrationBloc extends Bloc<EditCelebrationEvent, EditCelebrationState> {
  EditCelebrationBloc() : super(EditCelebrationInitial()) {
    on<EditCelebrationEvent>((event, emit) async {
      if (event is editCelebration) {
        emit(EditLoading());
        try {
          dbColl.celebration.doc(event.DocID).update(event.newData);
          emit(EditSuccess());
        } catch (e) {
          emit(EditFailure(errMessage: "couldn't add things"));
        }
      }
    });
  }
}
