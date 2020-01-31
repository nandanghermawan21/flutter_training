import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pelatihan_dasar_flutter/model/DetailViewModel.dart';
import 'package:pelatihan_dasar_flutter/model/GeolocatorModel.dart';
import 'package:pelatihan_dasar_flutter/model/customerModel.dart';
import 'package:pelatihan_dasar_flutter/view/DetailView.dart';
import 'package:pelatihan_dasar_flutter/main.dart' as main;

class Detail extends StatefulWidget {
  final CustomerModel customer;

  const Detail({Key key, this.customer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailView();
  }
}

abstract class DetailState extends State<Detail> {
  DetailViewModel data = new DetailViewModel();
  TextEditingController addressController = TextEditingController();

  List<String> reasons = [
    "Pindah Tempat Kerja",
    "Tempat Kurang Nyaman",
    "Mencari Tempat Lebih Luas",
    "Mencari Tempat Lebih Aman",
    "Habis Kontrak",
    "Belum Didefinisaikan",
  ];

  void setLivingStatus(bool status) {
    data.isStyInCurrentBase = status;
    data.commit();
  }

  void setReason(String reason) {
    data.reason = reason;
    data.commit();
  }

  void getAddress() {
    GeolocatorModel.myLocation().then((location) {
      data.lat = location.latitude;
      data.long = location.longitude;
      GeolocatorModel.getAddress(location.latitude, location.longitude)
          .then((adderss) {
        data.newAddress = adderss;
        addressController.text = adderss;
        data.commit();
      });
    });
  }

  void setAdress(String address) {
    data.newAddress = address;
    data.commit();
  }

  void confirmasiVisit() {
    main.homeViewModel.customers.forEach((f) {
      if (widget.customer.id == f.id) {
        f.isVisited = true;
        f.address = data.newAddress;
        f.lat = data.lat.toString();
        f.lon = data.long.toString();
      }
    });
    main.homeViewModel.commit();
    Navigator.of(context).pop();
  }

  Future getImage() async {
    File _image;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
    data.photo = getExtension(_image.toString()) +
        base64.encode(image.readAsBytesSync());
    data.commit();
  }

  UriData getUrilData() {
    return Uri.parse(data.photo).data;
  }

  String getExtension(String string) {
    List<String> getList = string.split(".");
    String data = getList.last.replaceAll("'", "");
    String result;
    if (data == "png") {
      result = "data:image/png;base64,";
    } else if (data == "jpeg") {
      result = "data:image/jpeg;base64,";
    } else if (data == "jpg") {
      result = "data:image/jpg;base64,";
    } else if (data == "gif") {
      result = "data:image/gif;base64,";
    }
    return result;
  }
}
