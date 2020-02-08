import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/Database/VisitQuery.dart';
import 'package:pelatihan_dasar_flutter/main.dart';
import 'package:pelatihan_dasar_flutter/model/customerModel.dart';
import 'package:pelatihan_dasar_flutter/view/HomeView.dart';
import 'package:pelatihan_dasar_flutter/main.dart' as main;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeView();
  }
}

abstract class HomeState extends State<Home> {
  @override
  void initState() {
    homeViewModel.customers = [];
    homeViewModel.commit();
    getDataCustomer();
    super.initState();
  }

  void getDataCustomer() {
    CustomerModel.getAll().then((onValue) {
      homeViewModel.customers = onValue;
      homeViewModel.commit();
    }).catchError((onError) {
      try {
        http.Response response = onError;
        print(response.statusCode);
      } catch (e) {
        print(onError);
      }
    });
  }

  void gotoDetail(CustomerModel item) {
    Navigator.of(context).pushNamed("detail", arguments: {
      "customerData": item,
    });
  }

  Future<bool> checkOnDbLocalExist(int customerId) async {
    return main.database.openConnection().then((db) {
      return db
          .rawQuery(VisitQuery.getByCustomerId(customerId))
          .then((onValue) {
        if (onValue.length > 0) {
          return true;
        } else {
          return false;
        }
      });
    });
  }

  void gotoWeb() {
    Navigator.of(context).pushNamed("web");
  }
}
