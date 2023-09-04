import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/get_customer_single_order.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/order/single_order_page.dart';

class OrderItem extends StatefulWidget {
  final int orderId;
  // final List<Map<String, dynamic>> cart;
  final String orderDateTime;

  OrderItem(
      {required this.orderId,
        // required this.cart,
        required this.orderDateTime,
      });

  @override
  State<OrderItem> createState() => _OrderItemState(
      orderId: orderId,
      // cart: cart,
      orderDateTime: orderDateTime,
  );
}

class _OrderItemState extends State<OrderItem> {
  final int orderId;
  // final List<Map<String, dynamic>> cart;
  final String orderDateTime;

  _OrderItemState(
      {required this.orderId,
        // required this.cart,
        required this.orderDateTime,
      });


  Future<GetCustomerSingleOrder> getCustomerSingleOrdersApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print('token');
    final userId = await prefs.getInt('userId');

    final token = await prefs.getString('token');

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('$baseUrl/get-order/$orderId'),
      headers: headers,
    );
    final responseData = jsonDecode(response.body);
    // print(responseData);

    // var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GetCustomerSingleOrder.fromJson(responseData);
    } else {
      return GetCustomerSingleOrder.fromJson(responseData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.transparent,
        elevation: 8,
        margin: EdgeInsets.all(10),
        child: FutureBuilder<GetCustomerSingleOrder>(
          future: getCustomerSingleOrdersApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onTap: () {
                  PageRouting.goToNextPage(
                    context: context,
                    navigateTo: SingleOrder(
                        orderId: orderId,
                        // cart: cart,
                        orderDateTime: orderDateTime,
                    ),
                  );
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          color: Color(0xFF0098B8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ORDER ID',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '#${snapshot.data!.data.orderNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Date:',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${orderDateTime}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status:',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${snapshot.data!.data.status}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Method:',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${snapshot.data!.data.paymentMethod}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${snapshot.data!.data.payAmount}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
