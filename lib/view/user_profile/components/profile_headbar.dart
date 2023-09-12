import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/get_user_data.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/view/user_profile/components/profile_body.dart';

class profileHeader extends StatelessWidget {
  const profileHeader({Key? key}) : super(key: key);

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
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.height,
        child: FutureBuilder<GetUserData>(
          future: getUserDataApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data;
              // print(userData);
              if (userData != null){
                return SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                      height: 200,
                      color: Color(0xFF0098B8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              userData!.customerName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${userData.customerContact} | ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  userData.customerEmail,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    profileBody(),
                  ],
              ),
                );
              } else {
                return Text('No data found');
        }
            } else {
              return Center(child: Container(child: CircularProgressIndicator()));
            }
          }
        ),
      ),
    );
  }
}
