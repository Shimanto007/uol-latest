import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/login_controller.dart';
import 'package:uol_new/model/get_user_data.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/authentication/login_screen.dart';
import 'package:uol_new/view/bottom_bar/my_bottom_bar.dart';
import 'package:uol_new/view/order/orders_screen.dart';
import 'package:uol_new/view/user_profile/my_profile/my_profile_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/cookie_policy_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/privacy_policy.dart';
import 'package:uol_new/view/user_profile/policy_screens/refund_return_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/shipping_delivery_screen.dart';
import 'package:uol_new/view/user_profile/policy_screens/terms_conditions_screen.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/view/user_profile/roality_points/royality_points_screen.dart';

class profileBody extends StatefulWidget {
  const profileBody({Key? key}) : super(key: key);

  @override
  State<profileBody> createState() => _profileBodyState();
}

class _profileBodyState extends State<profileBody> {
  final AuthController authController = Get.put(AuthController());

  Route nextroute = MaterialPageRoute(builder: (context) => MyBottomBar());

  Future<GetUserData> getUserDataApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final userId = await prefs.getInt('userId');
    final token = await prefs.getString('token');

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse(
          'https://ultimateasiteapi.com/api/get-edit-customer/$userId?platform=app'),
      headers: headers,
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GetUserData.fromJson(data);
    } else {
      return GetUserData.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<GetUserData>(
          future: getUserDataApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data;
              Size size = MediaQuery.of(context).size;
              return SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: size.height,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: authController.isLoggedIn.value
                                ? MyProfile(
                                    defaultId: userData!.customerId,
                                    defaultName: userData.customerName,
                                    defaultEmail: userData.customerEmail,
                                    defaultContact: userData.customerContact,
                                    defaultDob: userData.customerDob.toString(),
                                    defaultGender: userData.customerGender.toString(),
                                  )
                                : LoginPage(nextRoute: nextroute),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.person,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'My Profile',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: OrdersScreen(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Orders',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: RoyalityPoints(royalityPoints: userData!.loyaltyPoints),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Royality Points',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          authController.logout(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => LoginPage()),
                          // );

                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: CookiePolicy(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.cookie,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Cookie Policy',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: TermsConditions(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.library_books,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: RefundReturn(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.assignment_return,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Returns & Refund',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: ShippingDelivery(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.local_shipping,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Shipping & Delivery',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PageRouting.goToNextPage(
                            context: context,
                            navigateTo: PrivacyPolicy(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.privacy_tip,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: Color(0xFF0098B8),
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF0098B8),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Container(child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
