// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) {
  return CustomerModel(
    id: json['id'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    gender: json['gender'] as String,
    lat: json['lat'] as String,
    lon: json['lon'] as String,
    photo: json['photo'] as String,
    isVisited: json['isVisited'] as bool,
  );
}

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'gender': instance.gender,
      'lat': instance.lat,
      'lon': instance.lon,
      'photo': instance.photo,
      'isVisited': instance.isVisited,
    };
