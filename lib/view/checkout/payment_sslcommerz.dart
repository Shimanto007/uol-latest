// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/order/orders_screen.dart';

enum SdkType { TESTBOX, LIVE }

class SSLpayment extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SSLpayment> {
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
            'SSL Commerz',
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
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF0098B8)),
                      ),
                      child: Text("Pay with SSLCommerz now"),
                      onPressed: () {
                        sslCommerzGeneralCall();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> sslCommerzGeneralCall() async {
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
    final final_amount = prefs.getDouble('final_amount')!;
    final order_key = prefs.getInt('order_key').toString();
    // print(order_key);
    // print(final_amount);



    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        ipn_url: "https://securepay.sslcommerz.com/api/sslcommerz/ipn",
        multi_card_name: "",
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.LIVE,
        store_id: "ultimateorganiclifelive",
        store_passwd: "5F1D4D8EEC27620505",
        total_amount: final_amount,
        tran_id: order_key,
      ),
    ).addCustomerInfoInitializer(
      customerInfoInitializer: SSLCCustomerInfoInitializer(
        customerState: "",
        customerName: "${customer_name}",
        customerEmail: "${customer_email}",
        customerAddress1: "${customer_address}",
        customerCity: "${customer_city}",
        customerPostCode: "",
        customerCountry: "Bangladesh",
        customerPhone: "${customer_phone}",
      ),
    );

    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();
      // print(result);
      if (result.status!.toLowerCase() == "failed") {
        Fluttertoast.showToast(
          msg: "Transaction is Failed....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (result.status!.toLowerCase() == "closed") {
        Fluttertoast.showToast(
          msg: "SDK Closed by User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
            msg:
                "Transaction is ${result.status} and Amount is ${result.amount}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        final body = jsonEncode(result);
        final bodys = jsonDecode(body);
        // print(bodys);
        var url = '$baseUrl/sslcommerz/success';
        try {
          final response = await http.post(Uri.parse(url), body: bodys);
          final responseData = json.decode(response.body);
          // print(responseData);
          if (responseData['success'] == true) {
            PageRouting.goToNextPage(
              context: context,
              navigateTo: OrdersScreen(),
            );
          }
          // print(responseData["token"]);
        } catch (error) {
          // print(error);
          throw error;
        }
      }
    } catch (e) {
      // print(e);
      debugPrint(e.toString());
    }
  }

// Future<void> sslCommerzCustomizedCall() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final final_amount = prefs.getDouble('final_amount')!;
//   final order_key = prefs.getInt('order_key').toString();
//   print(order_key);
//   print(final_amount);
//   Sslcommerz sslcommerz = Sslcommerz(
//     initializer: SSLCommerzInitialization(
//       //Use the ipn if you have valid one, or it will fail the transaction.
//       ipn_url: "www.ipnurl.com",
//       multi_card_name: "",
//       currency: SSLCurrencyType.BDT,
//       product_category: "Food",
//       sdkType: SSLCSdkType.LIVE,
//       store_id: "ultimateorganiclifelive",
//       store_passwd: "5F1D4D8EEC27620505",
//       total_amount: 1760,
//       tran_id: "1122",
//     ),
//   );
//
//   sslcommerz
//       .addEMITransactionInitializer(
//           sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
//               emi_options: 1, emi_max_list_options: 9, emi_selected_inst: 0))
//       .addShipmentInfoInitializer(
//           sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
//               shipmentMethod: "yes",
//               numOfItems: 5,
//               shipmentDetails: ShipmentDetails(
//                   shipAddress1: "Ship address 1",
//                   shipCity: "Faridpur",
//                   shipCountry: "Bangladesh",
//                   shipName: "Ship name 1",
//                   shipPostCode: "7860")))
//       .addCustomerInfoInitializer(
//         customerInfoInitializer: SSLCCustomerInfoInitializer(
//           customerState: "Chattogram",
//           customerName: "Abu Sayed Chowdhury",
//           customerEmail: "sayem227@gmail.com",
//           customerAddress1: "Anderkilla",
//           customerCity: "Chattogram",
//           customerPostCode: "200",
//           customerCountry: "Bangladesh",
//           customerPhone: "",
//         ),
//       )
//       .addProductInitializer(
//           sslcProductInitializer:
//               // ***** ssl product initializer for general product STARTS*****
//               SSLCProductInitializer(
//         productName: "Water Filter",
//         productCategory: "Widgets",
//         general: General(
//           general: "General Purpose",
//           productProfile: "Product Profile",
//         ),
//       ));
//
//   try {
//     SSLCTransactionInfoModel result = await sslcommerz.payNow();
//
//     if (result.status!.toLowerCase() == "failed") {
//       Fluttertoast.showToast(
//           msg: "Transaction is Failed....",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     } else {
//       Fluttertoast.showToast(
//         msg: "Transaction is ${result.status} and Amount is ${result.amount}",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       final body = jsonEncode(result);
//       final bodys = jsonDecode(body);
//       // print(bodys);
//       const url = 'https://ultimateasiteapi.com/api/sslcommerz/success';
//       try {
//         final response = await http.post(Uri.parse(url), body: bodys);
//         final responseData = json.decode(response.body);
//         // print(responseData);
//         // print(responseData["token"]);
//       } catch (error) {
//         throw error;
//       }
//     }
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }
}
