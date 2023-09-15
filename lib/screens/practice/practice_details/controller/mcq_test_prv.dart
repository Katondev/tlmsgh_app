import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'dart:async';

class McqTestPrv extends ChangeNotifier {
  int? index = 0;
  int counter = 0;
  Arguments? arg;
  var timer;
  final int timerMaxSeconds = 1800;
  String timerText = '00:30:00';
  final PageController controller = PageController();

  Future<void> init(List<dynamic> args) async {
    if (arg?.title.isNotEmpty ?? false) {
      timer.cancel();
      timerText = "00:30:00";
    }
    startTimer();
    arg = args[0];
    notifyListeners();
  }

  void onNextPress() {
    index = (index ?? 0) + 1;
    controller.animateToPage(index ?? 0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
    notifyListeners();
  }

  void onPreviousPress() {
    index = (index ?? 0) - 1;
    controller.animateToPage(index ?? 0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
    notifyListeners();
  }

  void onPageChange(int value) {
    index = value;
    notifyListeners();
  }

  // String get timerText =>
  //     '${((timerMaxSeconds - counter) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - counter) % 60).toString().padLeft(2, '0')}';
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      counter = timer.tick;
      if (counter == timerMaxSeconds) {
        print('Cancel timer');
        timer.cancel();
        timerText = "00:00:00";
      }
      timerText =
          '00:${((timerMaxSeconds - counter) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - counter) % 60).toString().padLeft(2, '0')}';
      notifyListeners();
    });
  }
}
