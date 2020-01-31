import 'package:flutter/material.dart';

class NetworkModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool networkStatus = true;

  void commit() {
    notifyListeners();
  }
}
