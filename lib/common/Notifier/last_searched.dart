import 'package:flutter/cupertino.dart';

class LastSearched {
  static ValueNotifier<bool> isLastSearched = ValueNotifier(false);

  static void hideLastSearched() {
    isLastSearched.value = true;
  }
}
