import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/get_user_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/view/user_profile/components/profile_headbar.dart';

class UserProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';

  UserProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Future<GetUserData> getUserDataApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // print('token');
    final userId = await prefs.getInt('userId');
    print(userId);
    final token = await prefs.getString('token');
    print(token);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    final response = await http.get(
      Uri.parse(
          '$baseUrl/get-edit-customer/$userId?platform=app'),
      headers: headers,
    );

    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return GetUserData.fromJson(data);
    } else {
      return GetUserData.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.height,
        child: FutureBuilder<GetUserData>(
          future: getUserDataApi(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (snapshot.hasData) {
              final userData = snapshot.data;
              // print(userData);
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
                    'User Profile',
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
                body: SizedBox(
                    height: size.height,
                    width: size.height,
                    child: profileHeader(),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            // print(userData);
          },
        ),
      ),
    );
  }
}
