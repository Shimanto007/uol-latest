// To parse this JSON data, do
//
//     final getRedeemData = getRedeemDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetRedeemData getRedeemDataFromJson(String str) => GetRedeemData.fromJson(json.decode(str));

String getRedeemDataToJson(GetRedeemData data) => json.encode(data.toJson());

class GetRedeemData {
  bool success;
  Data data;
  String message;
  int code;

  GetRedeemData({
    required this.success,
    required this.data,
    required this.message,
    required this.code,
  });

  factory GetRedeemData.fromJson(Map<String, dynamic> json) => GetRedeemData(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  int discount;
  int redeemPoints;

  Data({
    required this.discount,
    required this.redeemPoints,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    discount: json["discount"],
    redeemPoints: json["redeemPoints"],
  );

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "redeemPoints": redeemPoints,
  };
}
