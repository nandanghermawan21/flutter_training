import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
part 'customerModel.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerModel {
  int id;
  String name;
  String address;
  String phone;
  String gender;
  String lat;
  String lon;
  String photo;
  bool isVisited;

  CustomerModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.gender,
    this.lat,
    this.lon,
    this.photo,
    this.isVisited,
  });

  factory CustomerModel.fromJson(json) => _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  static Future<List<CustomerModel>> getAll() {
    return http.get("http://dev.enerren.com/fluttertraining/api/Customer/get",
        headers: {
          "lang": "id",
          HttpHeaders.cacheControlHeader: "application/json",
        }).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((f) => CustomerModel.fromJson((f)))
            .toList();
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
