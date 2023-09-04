import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';

class MyProfile extends StatefulWidget {
  final int defaultId;
  final String defaultName;
  final String defaultEmail;
  final String defaultContact;
  final String defaultDob;
  final String defaultGender;


  const MyProfile({
    Key? key,
    required this.defaultId,
    required this.defaultName,
    required this.defaultEmail,
    required this.defaultContact,
    required this.defaultDob,
    required this.defaultGender,
  }) : super(key: key);

  @override
  _CustomerDetailsFormState createState() => _CustomerDetailsFormState();
}

class _CustomerDetailsFormState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();
  late int _id;
  late String _name;
  late String _email;
  late String _contact;
  late String _dob;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _id = widget.defaultId;
    _name = widget.defaultName;
    _email = widget.defaultEmail;
    _contact = widget.defaultContact;
    _dob = widget.defaultDob;
    _gender = widget.defaultGender;
  }
  var _isLoading = false;

  Future<dynamic> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    setState(() {
      _isLoading = false;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString('token');
    final userId = await prefs.getInt('userId');
    var url = '$baseUrl/get-edit-customer/$userId?platform=app';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(Uri.parse(url),headers: headers, body: {
        'id': userId.toString(),
        'customer_name': _name,
        'customer_email': _email,
        'customer_contact': _contact,
        'customer_dob': _dob,
        'customer_gender': _gender,
      });
      // print(response.body);

    } catch (error) {
      throw error;
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
          'My Profile',
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
        child: Container(
          padding: EdgeInsets.all(50),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0098B8),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _dob,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Date of Birth';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _dob = value!;
                    },
                  ),

                  TextFormField(
                    initialValue: _contact,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _contact = value!;
                    },
                  ),

                  SizedBox(height: 16),

                  if (_isLoading)
                    Center(
                        child: Container(child: CircularProgressIndicator())
                    )
                  else
                  Center(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF0098B8)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _submit();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Details updated successfully')),
                          );
                        }
                      },
                      child: Text(
                          'Save Changes',
                        style: TextStyle(
                          fontSize: 15,
                        ),
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
