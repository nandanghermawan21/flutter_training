
import 'package:flutter/widgets.dart';
import 'package:pelatihan_dasar_flutter/view/DetailView.dart';

class Detail extends StatefulWidget {
  const Detail();

  @override
  State<StatefulWidget> createState() {
    return DetailView();
  }
}

abstract class DetailState extends State<Detail> {
  TextEditingController addressController = TextEditingController();
}
