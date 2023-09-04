import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uol_new/controller/sign_up_controller.dart';
import 'package:uol_new/model/http_exception.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/authentication/otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _passwordController = TextEditingController();
  String? selectedGender = 'Male';
  DateTime? selectedDate;

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
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
      // Sign user up
      await _controller.signup(
        _authData['customer_name']!,
        _authData['customer_email']!,
        _authData['customer_password']!,
        _authData['customer_contact']!,
        selectedGender!,
        selectedDate.toString()!,
      );
      PageRouting.goToNextPage(
        context: context,
        navigateTo: OtpScreen(),
      );
    } on HttpException catch (error) {
      // print(error);
      // print(error.toString());
      var errorMessage = 'Authentication failed';

      if (error.toString().contains('customer_email') &&
          error.toString().contains('customer_contact')) {
        errorMessage = 'This Email & Contact is already in use';
      } else if (error.toString().contains('Email already exists')) {
        errorMessage = 'this email address is already in use';
      } else if (error
          .toString()
          .contains('The customer contact has already been taken.')) {
        errorMessage = 'this contact address is already in use';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate. Please try again later';
      _showErrorDialog(error.toString());
      // print(error);
    }
    setState(() {
      _isLoading = false;
    });
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
          'Sign Up',
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
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    suffixStyle: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  onSaved: (value) {
                    _authData['customer_name'] = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    suffixStyle: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  onSaved: (value) {
                    _authData['customer_contact'] = value!;
                  },
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
                    _authData['customer_password'] = value!;
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    suffixStyle: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains('@') && !value.contains('.')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['customer_email'] = value!;
                  },
                ),
                SizedBox(height: 16.0),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: DropdownButton<String>(
                    value: selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: <String>[
                      'Male',
                      'Female',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'Gender',
                //     suffixStyle: TextStyle(
                //       fontFamily: 'Lato',
                //     ),
                //   ),
                //   keyboardType: TextInputType.name,
                //   onSaved: (value) {
                //     _authData['customer_gender'] = value!;
                //   },
                // ),
                SizedBox(height: 16.0),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'Your Birthdate',
                //     suffixStyle: TextStyle(
                //       fontFamily: 'Lato',
                //     ),
                //   ),
                //   keyboardType: TextInputType.datetime,
                //   onSaved: (value) {
                //     _authData['customer_dob'] = value!;
                //   },
                // ),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black26))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date'),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          selectedDate != null
                              ? 'Selected Date: ${selectedDate.toString()}'
                              : 'No date selected',
                        ),

                      ],
                    ),
                ),
                SizedBox(height: 16.0),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child: Text(
                      'SIGN UP',
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
                      // padding: EdgeInsets.all(10.0),
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
