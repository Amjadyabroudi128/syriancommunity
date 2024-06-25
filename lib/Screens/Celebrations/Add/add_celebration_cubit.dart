import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_celebration_state.dart';

class AddCelebrationCubit extends Cubit<AddCelebrationState> {
  AddCelebrationCubit() : super(AddCelebrationInitial());
  final CollectionReference celebrations =
  FirebaseFirestore.instance.collection('Celebrations');
  Future <void> addCelebration ({required var url, required String name, required String details}) async {
    emit(AddLoading());
    try {
      if (url == null) {
        await celebrations.doc().set(
            {
              "name": name,
              "details": details
            }
        ); emit(AddSuccess());
      } else {
        await celebrations.doc().set(
            {
              "image": url,
              "name": name,
              "details": details
            }
        );   emit(AddSuccess());
      }
    } on FirebaseException catch (e){
      if(e.code == "No name") {
        emit(AddFailure(errMessage: "please add a name"));
      } else if (e.code == "no Details") {
        emit(AddFailure(errMessage: "pleasee add details"));
      }
    } catch (e) {
      emit(AddFailure(errMessage: "something else happened: $e"));
    }
  }
}