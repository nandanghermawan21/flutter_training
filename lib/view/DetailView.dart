import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/presenter/DetailPresenter.dart';

class DetailView extends DetailState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: <Widget>[
          Icon(
            Icons.network_wifi,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Colors.blue,
        child: RaisedButton(
          onPressed: () {},
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
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
                      Container(
                        child: Image.asset(
                          "assets/camera.png",
                          width: 150,
                          height: 150,
                        ),
                      ),
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
                        value: true,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (bool newValue) {},
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
                          value: "option1",
                          icon: Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String newValue) {},
                          items: List.generate(
                              <String>[
                                "option1",
                                "option2",
                                "option3",
                                "option3"
                              ].length, (i) {
                            return DropdownMenuItem<String>(
                              value: "option${i + 1}",
                              child: Text("option${i + 1}"),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Alasan Pindah Alamat?"),
                        IconButton(
                          onPressed: () {},
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
                            onChanged: (str) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("lat:"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("---------")
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("lon:"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("---------")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
