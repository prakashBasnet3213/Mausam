import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'changelabel_state.dart';

class ChangelabelCubit extends Cubit<ChangelabelState> {
  ChangelabelCubit() : super(ChangelabelInitial());

  void changeLabel(bool isUpdate) {
    emit(ChangelabelLoaded(isUpdate: isUpdate));
  }
}
