import 'package:flutter/material.dart';

class ChangesProvider with ChangeNotifier{

  void notifyAll() => notifyListeners();

}