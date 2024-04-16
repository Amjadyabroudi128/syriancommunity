import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_celebration_state.dart';

class AddCelebrationCubit extends Cubit<AddCelebrationState> {
  AddCelebrationCubit() : super(AddCelebrationInitial());

  Future <void> addCelebration ({required var url, required String name, required String details}) async {
    emit(AddLoading());
    if (url == null) {
      FirebaseFirestore.instance.collection("Celebrations").doc().set(
          {
            "name": name,
            "details": details
          }
      );
    } else {
      FirebaseFirestore.instance.collection("Celebrations").doc().set(
          {
            "url": url,
            "name": name,
            "details": details
          }
      );
      emit(AddSuccess());
    }
  }
}
