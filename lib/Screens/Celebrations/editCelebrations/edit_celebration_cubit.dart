import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_celebration_state.dart';

class EditCelebrationCubit extends Cubit<EditCelebrationState> {
  EditCelebrationCubit() : super(EditCelebrationInitial());
}
