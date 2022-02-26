import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mausam/presentation/bloc/ChangeLabel/changelabel_cubit.dart';

void main() {
  group(
    'Change Label Cubit test',
    () {
      late ChangelabelCubit changelabelCubit;
      setUp(
        () {
          changelabelCubit = ChangelabelCubit();
        },
      );
      tearDown(() {
        changelabelCubit.close();
      });
      blocTest<ChangelabelCubit, ChangelabelState>(
        'emits [MyState] when MyEvent is added.',
        build: () => ChangelabelCubit(),
        act: (ChangelabelCubit cubit) {
        
          cubit.changeLabel(true);
        },
        expect: () =>
            const <ChangelabelState>[ChangelabelLoaded(isUpdate: true)],
      );
    },
  );
}
