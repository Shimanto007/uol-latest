import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/controller/controller.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/bottom_bar/my_bottom_bar.dart';
import 'package:uol_new/view/homepage/home_page.dart';

class OrderSuccess extends StatefulWidget {
  final int orderNumber;

  OrderSuccess({required this.orderNumber});


  @override

  _OrderSuccessState createState() =>
      _OrderSuccessState(orderNumber: orderNumber);
}

class _OrderSuccessState extends State<OrderSuccess> {
  final int orderNumber;

  _OrderSuccessState({required this.orderNumber});
  final CartController cartController = Get.find<CartController>();

  void onInit() {

    cartController.loadCartItems();
    cartController.emptyCart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Color(0xFF0098B8),
        // ),
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Text(
          'Successful Order',
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.check,
                size: 80,
              ),
            ),
            Center(
              child: Text(
                'Thank You',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Thank You so much for your purchase. You will soon be notified when your order will be processed.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Your order number is',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  '$orderNumber',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF0098B8)),
                  ),
                  onPressed: () async {
                    cartController.emptyCart();
                    Get.offAll(MyBottomBar());
                    // PageRouting.goToNextPage(
                    //   context: context,
                    //   navigateTo: HomePage(),
                    // );
                  },
                  child: Text('Continue Shopping'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
