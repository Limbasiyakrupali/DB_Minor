import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool istapped = false;

  void Changetheme() {
    istapped = !istapped;
    notifyListeners();
  }
}
