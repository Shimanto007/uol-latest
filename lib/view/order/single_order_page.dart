import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/get_customer_single_order.dart';

class SingleOrder extends StatefulWidget {
  final int orderId;
  // final List<Map<String, dynamic>> cart;
  final String orderDateTime;

  SingleOrder(
      {required this.orderId,
        // required this.cart,
        required this.orderDateTime});

  @override
  State<SingleOrder> createState() =>
      _SingleOrder(
          orderId: orderId,
          // cart: cart,
          orderDateTime: orderDateTime);
}

class _SingleOrder extends State<SingleOrder> {
  final int orderId;
  // final List<Map<String, dynamic>> cart;
  final String orderDateTime;

  _SingleOrder(
      {required this.orderId,
        // required this.cart,
        required this.orderDateTime});

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

    // var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GetCustomerSingleOrder.fromJson(responseData);
    } else {
      return GetCustomerSingleOrder.fromJson(responseData);
    }
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
          child: FutureBuilder<GetCustomerSingleOrder>(
            future: getCustomerSingleOrdersApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFF0098B8),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'ORDER ID :',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '  #${snapshot.data!.data.orderNumber}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '#${orderDateTime}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black12,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data!.data.status}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xFF0098B8),
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'Lato',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Order Details',
                          style: TextStyle(
                            color: Color(0xFF0098B8),
                            fontSize: 20,
                            fontFamily: 'Lato',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black12,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF0098B8),
                                    size: 18.0,
                                  ),
                                  Text(
                                    '  ${snapshot.data!.data.shippingAddress}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Lato',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone_forwarded_outlined,
                                    color: Color(0xFF0098B8),
                                    size: 16.0,
                                  ),
                                  Text(
                                    '  ${snapshot.data!.data.shippingPhone}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Lato',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.price_change_outlined,
                                    color: Color(0xFF0098B8),
                                    size: 16.0,
                                  ),
                                  Text(
                                    '  ${snapshot.data!.data.payAmount}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Product Details',
                          style: TextStyle(
                            color: Color(0xFF0098B8),
                            fontSize: 20,
                            fontFamily: 'Lato',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: min(widget.cart.length * 20.0 + 600, 600),
                          // height: min(600, 600),
                          child: FutureBuilder<GetCustomerSingleOrder>(
                            future: getCustomerSingleOrdersApi(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // print(snapshot.data!.data.orderDetails[0]);
                                return Container(
                                  height: min(snapshot.data!.data.orderDetails.length * 20.0 + 600, 600),
                                  child: ListView.builder(
                                    itemCount:
                                        snapshot.data!.data.orderDetails.length,
                                    itemBuilder: (context, i) => Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "${snapshot.data!.data.orderDetails[i].productName} ",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Price: ${snapshot.data!.data.orderDetails[i].productPrice} BDT",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xFF0098B8)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Quantity',
                                                  style: TextStyle(
                                                    color: Color(0xFF0098B8),
                                                  ),
                                                ),
                                                Text(
                                                  '${snapshot.data!.data.orderDetails[i].productQuantity}',
                                                  style: TextStyle(
                                                    color: Color(0xFF0098B8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                          // child: ListView(
                          //   children: widget.cart.map((cart) => Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.grey.shade300,
                          //         borderRadius: BorderRadius.circular(10)
                          //     ),
                          //     margin: EdgeInsets.symmetric(vertical: 10),
                          //     padding: EdgeInsets.all(20),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: <Widget>[
                          //         Container(
                          //
                          //           width: 200,
                          //           child: Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               Container(
                          //                 child: Text(
                          //                   "${cart["name"]} ",
                          //                   style: TextStyle(
                          //                     fontSize: 14,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //               SizedBox(height: 10,),
                          //               Text(
                          //                 "Price: ${cart["price"]} BDT",
                          //                 style: TextStyle(
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.bold,
                          //                 ),
                          //               ),
                          //
                          //             ],
                          //           ),
                          //         ),
                          //         Container(
                          //           width: 80,
                          //           padding: EdgeInsets.all(5),
                          //           decoration: BoxDecoration(
                          //             border: Border.all(color: Color(0xFF0098B8)),
                          //             borderRadius: BorderRadius.circular(10)
                          //           ),
                          //           child: Column(
                          //             children: [
                          //               Text(
                          //                 'Quantity',
                          //                 style: TextStyle(
                          //                   color: Color(0xFF0098B8),
                          //                 ),
                          //               ),
                          //               Text(
                          //                 '${cart["quantity"]}',
                          //                 style: TextStyle(
                          //                   color: Color(0xFF0098B8),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),).toList(),
                          // ),
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
      ),
    );
  }
}
