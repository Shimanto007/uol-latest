import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/view/bottom_bar/my_bottom_bar.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  RxBool isLoggedIn = false.obs;
  RxString token = ''.obs;
  late SharedPreferences prefs;

  @override
  void onReady() async {
    super.onReady();
    await initPrefs();
    isLoggedIn.value = await checkLogin();
  }

  @override
  void initState() {
    checkLoginStatus();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> checkLogin() async {
    await Future.delayed(Duration(seconds: 1));
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> login(BuildContext context, String username, String password,
      Route nextroute) async {
    print(username);
    print(password);
    final url = Uri.parse("$baseUrl/customer/login?platform=app");
    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var body = json.encode({
      "user_input": username,
      "password": password,
    });

    final response = await http.post(
      url,
      body: body,
      headers: headers,
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    await Future.delayed(Duration(seconds: 1));
    final responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200 && responseData["status"] == true) {
      final responseData = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseData['token']);
      await prefs.setInt('userId', responseData['data']['id']);
      await prefs.setString(
          'user_customer_name', responseData['data']['customer_name']);
      await prefs.setBool('isLoggedIn', true);
      final userId = await prefs.getInt('userId');
      print(userId);
      final tokens = await prefs.getString('token');
      print(tokens);
      isLoggedIn.value = true;
      token.value = responseData['token'];
      Navigator.pushReplacement(context, nextroute);
      // print(nextroute);

    } else {
      print(responseData);
      throw Exception('${responseData["message"]}');
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    await prefs.remove('token');
    await prefs.setBool('isLoggedIn', false);

    isLoggedIn.value = false;
    token.value = '';
    Get.offAll(MyBottomBar());
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    token.value = prefs.getString('token') ?? '';
  }
}
