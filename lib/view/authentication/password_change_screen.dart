import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/forget_password_controller.dart';
import 'package:uol_new/controller/login_controller.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/authentication/login_screen.dart';
import 'package:uol_new/view/authentication/sign_up_screen.dart';
import 'package:uol_new/view/bottom_bar/my_bottom_bar.dart';
import 'package:uol_new/view/user_profile/user_profile_screen.dart';

import '../../model/http_exception.dart';

class PasswordChange extends StatefulWidget {
  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final ForgetPasswordController _controller =
      Get.put(ForgetPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Route nextroute =
        MaterialPageRoute(builder: (context) => UserProfileScreen());

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Get.offAll(LoginPage(nextRoute: nextroute));
              Navigator.of(ctx).pop(MaterialPageRoute(builder: (context) => MyBottomBar()));
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  Future<dynamic> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    try {
      // Sign user up
      await _controller.otp_verification(
        _authData['otp']!,
        _authData['password']!
      );
      PageRouting.goToNextPage(
        context: context,
        navigateTo: LoginPage(nextRoute: nextroute),
      );
    } on HttpException catch (error) {
      // print(error);
      // print(error.toString());
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(error.toString());
      // print(error);
    }
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
          'Password Change',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            // height: 500,
            child: ListView(
              children: [
                CachedNetworkImage(
                  width: 50,
                  imageUrl:
                      'https://ultimateasiteapi.com/admin/images/logo.png',
                  placeholder: (context, url) => Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'OTP',
                    suffixStyle: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  onSaved: (value) {
                    _authData['otp'] = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixStyle: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  // validator: (value) {
                  //   if (value.isEmpty || value.length < 1) {
                  //     return 'Password is too short!';
                  //   }
                  // },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixStyle: TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                    }),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                    ),
                    onPressed: _submit,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0098B8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // padding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
