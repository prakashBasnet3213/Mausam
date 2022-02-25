part of 'changelabel_cubit.dart';

abstract class ChangelabelState extends Equatable {
  const ChangelabelState();

  @override
  List<Object> get props => [];
}

class ChangelabelInitial extends ChangelabelState {}

class ChangelabelLoaded extends ChangelabelState {
  final bool isUpdate;
  const ChangelabelLoaded({required this.isUpdate});
  @override
  List<Object> get props => [isUpdate];
}
