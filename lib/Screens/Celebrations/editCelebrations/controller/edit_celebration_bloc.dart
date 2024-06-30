import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_celebration_event.dart';
part 'edit_celebration_state.dart';

class EditCelebrationBloc extends Bloc<EditCelebrationEvent, EditCelebrationState> {
  EditCelebrationBloc() : super(EditCelebrationInitial()) {
    on<EditCelebrationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
