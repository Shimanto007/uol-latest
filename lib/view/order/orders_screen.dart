import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/get_customer_order.dart';
import 'package:uol_new/view/order/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<List<GetCustomerOrders>> getCustomerOrdersApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final userId = await prefs.getInt('userId');
    final token = await prefs.getString('token');
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('$baseUrl/get-customer-orders/$userId?platform=app'),
      headers: headers,
    );

    List<dynamic> jsonResponse = json.decode(response.body);
    // print(jsonResponse.runtimeType);

    final data =
        jsonResponse.map((order) => GetCustomerOrders.fromJson(order)).toList();
    if (response.statusCode == 200) {
      return jsonResponse
          .map((order) => GetCustomerOrders.fromJson(order))
          .toList();
    } else {
      return jsonResponse
          .map((order) => GetCustomerOrders.fromJson(order))
          .toList();
    }
  }



  @override
  void initState() {
    super.initState();
    this.getCustomerOrdersApi();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getCustomerOrdersApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF0098B8),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: Text(
            'Your Orders',
            style: TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF0098B8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<GetCustomerOrders>>(
        future: getCustomerOrdersApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final customerOrders = snapshot.data!;
            List<OrderDetail> cart = customerOrders[0].orderDetails;
            // print(cart.length);
            List<Map<String, dynamic>> cartList =
                cart.map((orderDetail) => orderDetail.toJson()).toList();
            // print(cartList);
            // print(customerOrders[0].orderDateTime);
            return ListView.builder(
              itemCount: customerOrders.length,
              itemBuilder: (ctx, i) => OrderItem(
                orderId: customerOrders[i].id,
                // cart: customerOrders[i].orderDetails.map((orderDetail) => orderDetail.toJson()).toList(),
                orderDateTime: customerOrders[i].orderDateTime,
              ),
            );
          } else {
            return Center(
              child: Container(
                child: Center(
                  child: Text(
                    'No Orders To show',
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
