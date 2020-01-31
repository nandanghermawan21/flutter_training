import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/model/customerModel.dart';

class HomeViewModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<CustomerModel> customers = [];

  void commit() {
    notifyListeners();
  }
}
