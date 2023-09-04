import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uol_new/controller/login_controller.dart';
import 'package:uol_new/view/authentication/login_screen.dart';
import 'package:uol_new/view/cart/cart_screen.dart';
import 'package:uol_new/view/category/all_category_screen.dart';
import 'package:uol_new/view/order/orders_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/privacy_policy.dart';
import 'package:uol_new/view/user_profile/policy_screens/refund_return_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/shipping_delivery_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/terms_conditions_screen.dart';
import 'package:uol_new/view/user_profile/user_profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Route nextrouteOrder = MaterialPageRoute(builder: (context) => OrdersScreen());
    Route nextrouteCart = MaterialPageRoute(builder: (context) => CartScreen());
    final AuthController authController = Get.put(AuthController());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            child: DrawerHeader(
              // padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Ultimate Organic Life',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF0098B8),
              ),
            ),
          ),
          ListTile(
            title: Text('Category'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => all_category_grid()),
              );
            },
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>(authController.isLoggedIn == true) ? OrdersScreen() : LoginPage(nextRoute: nextrouteOrder)),
              );
              // Obx(() {
              //   if(authController.isLoggedIn == true) {
              //     return OrdersScreen();
              //   } else {
              //     return LoginPage(nextRoute: nextrouteOrder);
              //   }
              // });
            },
          ),
          ListTile(
            title: Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>(authController.isLoggedIn == true) ? CartScreen() : LoginPage(nextRoute: nextrouteCart)),
              );
              // Obx(() {
              //   if(authController.isLoggedIn == true) {
              //     return OrdersScreen();
              //   } else {
              //     return LoginPage(nextRoute: nextrouteOrder);
              //   }
              // });
            },
          ),
          ListTile(
            title: Text('Terms & Conditions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsConditions()),
              );
            },
          ),
          ListTile(
            title: Text('Return & Refund'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RefundReturn()),
              );
            },
          ),
          ListTile(
            title: Text('Shipping & Delivery'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShippingDelivery()),
              );
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              );
            },
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}
