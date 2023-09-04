import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/http_exception.dart';

class ForgetPasswordController extends GetxController {
  dynamic customer_id;

  Future<dynamic> forgetPassword(
    String name,
  ) async {
    var urs = '$baseUrl/forget-customer-password';
    try {
      final response = await http.post(Uri.parse(urs), body: {
        'user_input': name,
      });
      final responseData = json.decode(response.body);
      // print(responseData);
      customer_id = responseData["data"]["customer_id"];
      // print(customer_id);

      if (responseData["success"] == false) {
        throw HttpException(responseData["message"].toString());
      }

    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> otp_verification(dynamic otp, String password) async {
    final url = '$baseUrl/verify-reset-customer-password/${customer_id}';
    print(url);
    try {
      final response = await http.post(Uri.parse(url), body: {
        'password': password,
        'otp': otp
      });
      final responseData = json.decode(response.body);
      // print(responseData);

      if (responseData["success"] == true) {
        throw HttpException(responseData["message"]);
      } else {
        throw HttpException(responseData["message"]);
      }
    } catch (error) {
      throw error;
    }
  }
}
