import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pelatihan_dasar_flutter/Database/VisitQuery.dart';
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

  @override
  void initState() {
    super.initState();
    //get from db
    main.database.openConnection().then((db) {
      db
          .query("tbl_visit", where: "customer_id = ${widget.customer.id}")
          .then((onValue) {
        if (onValue.length > 0) {
          data.photo = onValue.first["photo"];
          data.isStyInCurrentBase =
              onValue.first["is_stay_in_current_base"] == 0 ? false : true;
          data.reason = onValue.first["reason"];
          data.newAddress = onValue.first["new_address"];
          data.lat = onValue.first["lat"];
          data.long = onValue.first["lon"];
          addressController.text = data.newAddress;
          data.commit();
        }
      });
    });
  }

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
    data.onLoading = true;
    data.commit();
    if (main.networkModel.networkStatus == false) {
      insertIntoLocalDb();
    } else {
      CustomerModel.confirmVisit(
        customerId: widget.customer.id,
        isStyInCurrentBase: data.isStyInCurrentBase,
        newAddress: data.newAddress,
        lat: data.lat,
        lon: data.long,
        photo: data.photo,
        reason: data.reason,
      ).then((onValue) {
        data.onLoading = false;
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
      }).catchError((onError) {
        print(onError);
        data.onLoading = false;
        data.commit();
      });
    }
  }

  void insertIntoLocalDb() {
    main.database.openConnection().then((db) {
      //check if exist
      db
          .rawQuery(VisitQuery.getByCustomerId(widget.customer.id))
          .then((result) {
        if (result.length > 0) {
          db.rawQuery(VisitQuery.update(widget.customer.id, data));
        } else {
          db.rawQuery(VisitQuery.insert(widget.customer.id, data));
        }
        data.onLoading = false;
        data.commit();
        return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 100,
              child: Center(
                child: Text(
                  "Tidak ada koneksi internet data sementara disimpan didalam perangkat",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      }).catchError((onError) {});
    }).catchError((onError) {});
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
