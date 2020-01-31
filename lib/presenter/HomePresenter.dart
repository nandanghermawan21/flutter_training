import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/view/HomeView.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeView();
  }
}

abstract class HomeState extends State<Home> {

   @override
  void initState() {
    super.initState();
  }
}
