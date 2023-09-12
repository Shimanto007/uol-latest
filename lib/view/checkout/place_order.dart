import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/controller.dart';
import 'package:uol_new/view/checkout/payment_sslcommerz.dart';
import 'package:uol_new/view/checkout/success_order_screen.dart';

import '../../route/routes.dart';

Future<dynamic> ordereds(_paymentMethod, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final customer_name = await prefs.getString('customer_name');
  final customer_email = await prefs.getString('customer_email');
  final customer_phone = await prefs.getString('customer_phone');
  final customer_address = await prefs.getString('customer_address');
  final customer_city = await prefs.getInt('customer_city_shipping');
  final customer_zip = await prefs.getString('customer_zip');
  final shipping_area = await prefs.getString('shipping_area');
  final shipping_cost = await prefs.getString('shipping_cost');
  final cartim = prefs.getString('cartData');
  final customer_id = prefs.getInt('userId');
  final user_name = prefs.getString('user_customer_name');
  final user_email = prefs.getString('customer_email');
  final user_phone = prefs.getString('customer_contact');
  final user_address = prefs.getString('customer_address');
  final List<dynamic> products = jsonDecode(cartim!);

  final Map body = {
    "customer_id": "$customer_id",
    "customer_details": {
      "customer_name": "$user_name",
      "customer_email": "$user_email",
      "customer_phone": "$user_phone",
      "customer_address": "$user_address",
      "customer_city": "",
      "customer_zip": ""
    },
    "shipping_details": {
      "customer_name": "$customer_name",
      "customer_email": "$customer_email",
      "customer_phone": "$customer_phone",
      "customer_address": "$customer_address",
      "customer_city": customer_city,
      "customer_zip": "$customer_zip",
      "shipping_area": "$shipping_area",
    },
    "products": products,
    "order_note": " ",
    "payment_method": "$_paymentMethod",
    "shipping_cost": "$shipping_cost",
    "vat": "0.00",
    "coupon_id": null,
    "order_from": "app",
    "pointApply": false,
  };
  // print(body);
  // print(products);

  try {
    final data = jsonEncode(body);
    await prefs.setString('json-product', data);
    print(data);
    final token = await prefs.getString('token');
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('https://ultimateasiteapi.com/api/order?platform=app'),
      headers: headers,
      body: data,
    );
    final responseData = json.decode(response.body);
    print(responseData);

    if (responseData['success'] == true && responseData['code'] == 200 && responseData['success'] != null) {
      cartController.emptyCart();
      if (_paymentMethod == 'ssl') {
        await prefs.setInt('order_key', responseData['data']);
        final ordss = prefs.getInt('order_key');
        await prefs.setString('order_message', responseData['message']);
        final text = prefs.getString('order_message');
        print(responseData);
        PageRouting.goToNextPage(
          context: context,
          navigateTo: SSLpayment(),
        );

        return responseData['success'];

      } else if (_paymentMethod == 'cod') {
        await prefs.setInt('order_key', responseData['data']);
        final ordss = prefs.getInt('order_key');
        await prefs.setString('order_message', responseData['message']);
        await prefs.setInt('order_number', responseData['data']);
        final orderNumber = prefs.getInt('order_number');
        final text = prefs.getString('order_message');
        print(responseData);
        PageRouting.goToNextPage(
          context: context,
          navigateTo: OrderSuccess(orderNumber: responseData['data'],),
        );
        return responseData['success'];
      }
      // await prefs.setInt('order_key', responseData['data']);
      // final ordss = prefs.getInt('order_key');
      // await prefs.setString('order_message', responseData['message']);
      // final text = prefs.getString('order_message');
      // print(text);
      // return responseData['success'];
    } else if (responseData['success'] == false) {
      await prefs.setString('order_message', responseData['message']);
      final text = prefs.getString('order_message');
      return responseData['success'];
    }
  } catch (error) {
    print(error);
    throw error;
  }
}
