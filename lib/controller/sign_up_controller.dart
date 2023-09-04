import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/http_exception.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  dynamic customer_id;


  Future<dynamic> signup(
      String name,
      String email,
      String password,
      String contact_number,
      String gender,
      String birthdate,
      ) async {
    var urs = '$baseUrl/register-customer?platform=app';
    try {
      final response = await http.post(Uri.parse(urs), body: {
        'customer_name': name,
        'customer_email': email,
        'customer_password': password,
        'customer_contact': contact_number,
        'customer_gender': gender,
        'customer_dob': birthdate,
      });
      final responseData = json.decode(response.body);
      // print(responseData);

      if (responseData["success"] == false) {
        if (responseData["message"].toString().contains("customer_contact") &&
            responseData["message"].toString().contains("customer_email")) {
          throw HttpException(responseData["message"].toString());
        } else if (responseData["message"]
            .toString()
            .contains("customer_email")) {
          throw HttpException(
              responseData["message"]["customer_email"].toString());
        } else if (responseData["message"]
            .toString()
            .contains("customer_contact")) {
          throw HttpException(
              responseData["message"]["customer_contact"].toString());
        }
      }
      customer_id = responseData["customer"]["id"];
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> otp_verification(dynamic otp) async {

    final url =
        '$baseUrl/otp-verification/${customer_id}?platform=app';
    try {
      final response = await http.post(Uri.parse(url), body: {
        'otp': otp,
      });
      final responseData = json.decode(response.body);

      if (responseData["success"] == false) {
        throw HttpException(responseData["message"]["otp"][0].toString());
      }
    } catch (error) {
      throw error;
    }
  }
}
