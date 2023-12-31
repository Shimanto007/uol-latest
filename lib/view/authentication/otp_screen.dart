import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/sign_up_controller.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/authentication/login_screen.dart';
import 'package:uol_new/view/user_profile/user_profile_screen.dart';


class OtpScreen extends StatelessWidget {
  static const routeName = '/reg_otp';


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: NetworkImage(
                        'https://ultimateasiteapi.com/admin/images/logo.png'),
                    width: 200,
                    height: 200,
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                      // ..translate(-10.0),
                      child: Text(
                        'Ultimate Organic Life',
                        style: TextStyle(
                          color: Color(0xFF0098B8),
                          fontSize: 28,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // flex: deviceSize.width > 600 ? 2 : 1,
                    child: OtpCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpCard extends StatefulWidget {
  const OtpCard({
    Key? key,
  }) : super(key: key);

  @override
  _OtpCard createState() => _OtpCard();
}

class _OtpCard extends State<OtpCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final SignUpController _controller = Get.put(SignUpController());
  Route nextroute = MaterialPageRoute(builder: (context) => UserProfileScreen());
  Map<String, String> _authData = {
    'otp': '',
  };
  var _isLoading = false;



  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
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

  Future<dynamic> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await _controller.otp_verification(
        _authData['otp'],
      );
      PageRouting.goToNextPage(
        context: context,
        navigateTo: LoginPage(nextRoute: nextroute),
      );
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);

    } catch (error) {
      const errorMessage = 'Could not authenticate. Please try again later';
      _showErrorDialog(errorMessage);
      // print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    int _value = 0;
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 260,
      constraints:
      BoxConstraints(minHeight: 260),
      width: deviceSize.width * 0.85,
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Your Otp',
                  suffixStyle: TextStyle(
                    fontFamily: 'Lato',
                  ),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _authData['otp'] = value!;
                },
              ),


              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  child: Text(
                    'Verify Otp',
                    style: TextStyle(
                      color: Colors.white,
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
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
