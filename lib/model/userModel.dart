import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserModel {
  int id;
  String username;
  String password;
  String name;
  String phone;
  String address;
  String token;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.phone,
    this.address,
    this.token,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return new UserModel(
      id: jsonData["id"] as int,
      username: jsonData["username"],
      password: jsonData["password"],
      phone: jsonData["phone"],
      address: jsonData["address"],
      token: jsonData["token"],
      name: jsonData["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "phone": phone,
      "address": address,
      "token": token,
      "name": name,
    };
  }

  static Future<UserModel> login({
    @required String username,
    @required String password,
  }) {
    return http
        .post(
      "http://dev.enerren.com/FlutterTraining/api/Auth/user-login",
      headers: {
        "lang": "id",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({
        "userName": username,
        "password": password,
      }),
    )
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      } else if (statusCode == 400) {
        throw response.body;
      } else {
        throw response;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
