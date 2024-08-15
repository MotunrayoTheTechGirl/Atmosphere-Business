import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppController extends ChangeNotifier {
  int _pageListIndex = 0;
  int get pageListIndex => _pageListIndex;

  set newPageIndex(newIndex) {
    _pageListIndex = newIndex;
    notifyListeners();
  }
}

final appControllerProvider = ChangeNotifierProvider<AppController>((ref) {
  return AppController();
});
