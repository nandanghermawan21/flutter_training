import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/model/DetailViewModel.dart';
import 'package:pelatihan_dasar_flutter/model/networkModel.dart';
import 'package:pelatihan_dasar_flutter/presenter/DetailPresenter.dart';
import 'package:provider/provider.dart';

class DetailView extends DetailState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailViewModel>(
      create: (ctx) => super.data,
      child: Consumer<DetailViewModel>(
        builder: (ctx, dt, body) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Detail"),
              actions: <Widget>[
                Consumer<NetworkModel>(
                  builder: (c, data, child) {
                    return Icon(
                      data.networkStatus == false
                          ? Icons.network_check
                          : Icons.network_wifi,
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: RaisedButton(
                onPressed: confirmasiVisit,
                color: Colors.transparent,
                child: Container(
                  child: Center(
                    child: Text(
                      "Konfirmasi Kunjungan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: getImage,
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 3)),
                            child: Stack(
                              children: <Widget>[
                                Consumer<DetailViewModel>(
                                  builder: (ctx, dt, child) {
                                    if (dt.photo == null) {
                                      return Container(
                                        child: Image.asset(
                                          "assets/camera.png",
                                          width: 150,
                                          height: 150,
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        child: Image.memory(
                                          (getUrilData().contentAsBytes()),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Apakah tempat tinggal masih sama?"),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                height: 30,
                                child: DropdownButton<bool>(
                                  value: dt.isStyInCurrentBase,
                                  icon: Icon(Icons.arrow_drop_down),
                                  isExpanded: true,
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (bool newValue) {
                                    super.setLivingStatus(newValue);
                                  },
                                  items: <DropdownMenuItem<bool>>[
                                    DropdownMenuItem<bool>(
                                      value: true,
                                      child: Text(
                                        "Masih Sama",
                                      ),
                                    ),
                                    DropdownMenuItem<bool>(
                                      value: false,
                                      child: Text(
                                        "Telah Pindah",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey,
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Alasan Pindah Alamat?"),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: double.infinity,
                                height: 30,
                                child: DropdownButton<String>(
                                    value: dt.reason,
                                    icon: Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String newValue) {
                                      super.setReason(newValue);
                                    },
                                    items: List.generate(super.reasons.length,
                                        (i) {
                                      return DropdownMenuItem<String>(
                                        value: super.reasons[i],
                                        child: Text(super.reasons[i]),
                                      );
                                    })),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey,
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Alasan Pindah Alamat?"),
                                  IconButton(
                                    onPressed: getAddress,
                                    icon: Icon(
                                      Icons.pin_drop,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 10),
                                    height: 100,
                                    child: TextField(
                                      controller: super.addressController,
                                      maxLines: 10,
                                      textAlign: TextAlign.justify,
                                      onChanged: super.setAdress,
                                    ),
                                  ),
                                  Consumer<DetailViewModel>(
                                    builder: (ctx, dt, child) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("lat:"),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text("${data.lat}")
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("lon:"),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text("${dt.long}")
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                dt.onLoading == true
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.grey.withOpacity(0.3),
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
