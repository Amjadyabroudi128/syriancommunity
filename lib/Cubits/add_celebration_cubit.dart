import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_celebration_state.dart';

class AddCelebrationCubit extends Cubit<AddCelebrationState> {
  AddCelebrationCubit() : super(AddCelebrationInitial());

  Future <void> addCelebration ({required var url, required String name, required String details}) async {
    final CollectionReference celebrations =
    FirebaseFirestore.instance.collection('Celebrations');
    emit(AddSuccess());
    if (url == null) {
     await celebrations.doc().set(
          {
            "name": name,
            "details": details
          }
      );
    } else {
     await  celebrations.doc().set(
          {
            "image": url,
            "name": name,
            "details": details
          }
      );  emit(AddLoading());
    }
  }
}
