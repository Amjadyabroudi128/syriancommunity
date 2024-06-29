import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:syrianadmin/classes/pickImage.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    final CollectionReference celebrations =
    FirebaseFirestore.instance.collection('Celebrations');
    on<AddEvent>((event, emit) async{
      emit(AddLoading());
      if (event is addCelebration) {
        try {
          if (url == null) {
            await celebrations.doc().set(
                {
                  "name": event.name,
                  "details": event.details
                }
            ); emit(AddSuccess());
          } else {
            await celebrations.doc().set(
                {
                  "image": url,
                  "name": event.name,
                  "details": event.details
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
    });
  }
}
