import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/controller/login_controller.dart';
import 'package:uol_new/model/cart.dart';
import 'package:uol_new/view/authentication/login_screen.dart';
import 'package:uol_new/view/checkout/shipping_detail_screen.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Route nextroute = MaterialPageRoute(builder: (context) => CartScreen());
  final CartController cartController = Get.put(CartController());
  final AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    cartController.loadCartItems();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Successfull',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Cart',
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
      body: SingleChildScrollView(
        child: Obx(() {
          // print(cartController.cartItems.isNotEmpty);
          if (cartController.cartItems.isEmpty) {
            return Center(
              child: Container(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Cart is Empty',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 20,

                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Color(0xFF0098B8),
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Total: BDT ${cartController.cartTotal.toStringAsFixed(2) ?? 0.0}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    child: Container(
                      height: 680,
                      child: ListView.builder(
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CartItem item = cartController.cartItems[index];
                          // print(cartController.cartItems[index]);
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7.0, horizontal: 2.0),
                              child: ListTile(
                                visualDensity: VisualDensity(
                                  vertical: 3,
                                  horizontal: 1,
                                ),
                                leading: Image(
                                  image: NetworkImage('${item.image}'),
                                  width: 40,
                                  fit: BoxFit.fitWidth,
                                ),
                                title: Container(
                                  width: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title ?? 'Cart is empty',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Size: ${item.variantValue}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Text(
                                  'price: ${(item.price)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Container(
                                  width: 150,
                                  // height: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Quantity'),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    item.qty++;
                                                  });
                                                  cartController
                                                      .saveCartItems();
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 12,
                                                ),
                                              ),
                                              Text(
                                                '${item.qty}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  if (item.qty > 1) {
                                                    setState(() {
                                                      item.qty--;
                                                    });
                                                    cartController
                                                        .saveCartItems();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 20,
                                        child: IconButton(
                                          onPressed: () {
                                            if (item.qty > 0) {
                                              setState(() {
                                                item.qty--;
                                              });
                                              cartController
                                                  .removeItemFromCart(item);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
            );
          }
        }),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 380,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FloatingActionButton(
              onPressed: () async {
                if (cartController.cartItems
                    .map((item) => item.toJson())
                    .toList()
                    .isNotEmpty) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String cartDataJson = json.encode(cartController.cartItems
                      .map((item) => item.toJson())
                      .toList());
                  await prefs.setString('cartData', cartDataJson);
                  final cartim = prefs.getString('cartData');
                  final carts = jsonDecode(cartim!);
                  // print(cartim);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => authController.isLoggedIn.value
                            ? ShippingDetailsScreen()
                            : LoginPage(
                                nextRoute: nextroute,
                              )),
                  );
                } else {
                  _showErrorDialog('Cart is Empty');
                }
              },
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: Border(),
              backgroundColor: Color(0xFF0098B8),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
