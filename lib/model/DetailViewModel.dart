import 'package:flutter/material.dart';

class DetailViewModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool onLoading = false;
  String photo;
  bool isStyInCurrentBase = true;
  String newAddress = "";
  String reason;
  double lat;
  double long;

  void commit() {
    notifyListeners();
  }
}
