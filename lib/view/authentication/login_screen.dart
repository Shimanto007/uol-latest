import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/login_controller.dart';
import 'package:uol_new/view/authentication/forget_password_screen.dart';
import 'package:uol_new/view/authentication/sign_up_screen.dart';

class LoginPage extends StatefulWidget {
  final Route nextRoute;
  LoginPage({required this.nextRoute});

  @override
  State<LoginPage> createState() => _LoginPageState(nextRoute: nextRoute);
  final AuthController authController = Get.put(AuthController());
}

class _LoginPageState extends State<LoginPage> {
  final Route nextRoute;

  _LoginPageState({required this.nextRoute});

  final authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF0098B8),),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),

        title: Text(
          'Login',
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
                    width: 100,
                    imageUrl: 'https://ultimateasiteapi.com/admin/images/logo.png',
                    placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey,
                      child: Container(
                        width: 200,
                        height: 200,
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
                      hintText: 'E-mail or Contact number',
                      suffixStyle: TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await authController.login(
                              context,
                              _usernameController.text,
                              _passwordController.text,
                              nextRoute
                            );
                            final prefs = await SharedPreferences.getInstance();
                            FocusScope.of(context).unfocus();// dismiss keyboard

                          } catch (error) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('An error occured'),
                                content: Text('$error'),
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
                            print(error);
                            throw error;
                          }
                        }
                      },
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
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Sign up instead',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        // padding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Lato',
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgetPassword()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
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
