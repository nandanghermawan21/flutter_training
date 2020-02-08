import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/model/customerModel.dart';
import 'package:pelatihan_dasar_flutter/model/HomeViewModel.dart';
import 'package:pelatihan_dasar_flutter/presenter/HomePresenter.dart';
import 'package:provider/provider.dart';

class HomeView extends HomeState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 100,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 50,
                        ),
                        Consumer<HomeViewModel>(
                          builder: ((ctx, dt, child) {
                            return Text(
                              "${dt.customers.length}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.assistant_photo,
                          color: Colors.white,
                          size: 50,
                        ),
                        Consumer<HomeViewModel>(
                          builder: ((ctx, dt, child) {
                            return Text(
                              "${dt.customers.where((x) => x.isVisited).toList().length}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: gotoWeb,
                    child: Container(
                      width: 50,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.satellite,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            "Web",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<HomeViewModel>(
            builder: ((ctx, dt, child) {
              return Expanded(
                child: ListView(
                  children: List.generate(dt.customers.length, (i) {
                    return listCustomer(context, dt.customers[i]);
                  }),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget listCustomer(BuildContext context, CustomerModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              offset: Offset(2, 2),
              blurRadius: 5)
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                image: DecorationImage(
                  image: NetworkImage("${item.photo}"),
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${item.name}",
                    style: TextStyle(
                      fontFamily: "catedral",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("${item.address}"),
                  )
                ],
              ),
            ),
          ),
          FutureBuilder<bool>(
            future: checkOnDbLocalExist(item.id),
            initialData: true,
            builder: ((ctx, dt) {
              return GestureDetector(
                onTap: () {
                  super.gotoDetail(item);
                },
                child: Container(
                  width: 30,
                  child: Center(
                    child: Icon(
                      Icons.assistant_photo,
                      size: 30,
                      color: item.isVisited == true
                          ? Colors.blue
                          : dt.data ? Colors.yellow : Colors.grey.shade500,
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
