import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/firebase_api/firebase_api.dart';
import 'package:uol_new/route/app_page.dart';
import 'package:uol_new/route/app_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  print(appName);
  print(packageName);
  print(version);
  print(buildNumber);

  await FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update App Demo',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  final cartController = Get.put(CartController());
  Completer<void> _updateCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    checkAndUpdateAppVersion();
  }

  Future<String> getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> checkAndUpdateAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    var snap = await FirebaseFirestore.instance
        .collection('appVersion')
        .doc('5A514qqU9kxzh8jqCMcr')
        .get();
    var latestVersion = snap.get('appVersion');
    print(snap.get('appVersion'));

    if (currentVersion != latestVersion) {
      showUpdateDialog(context);
    }
  }

  void showUpdateDialog(BuildContext context) {
    if (!_updateCompleter.isCompleted) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing the dialog
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text(
              'Update Required',
              style: TextStyle(
                color: Color(0xFF0098B8),
              ),
            ),
            content: Text(
                'A new version of the app is available. Please update to continue using the app.'),
            actions: [
              TextButton(
                child: Text(
                  'Update Now',
                  style: TextStyle(
                    color: Color(0xFF0098B8),
                  ),
                ),
                onPressed: () async {
                  final url =
                      'https://play.google.com/store/apps/details?id=com.uol.ultimateorganiclife';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
            ],
          );
        },
      ).then((_) {
        if (!_updateCompleter.isCompleted) {
          _updateCompleter.complete();
        }
      });
    }
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GetMaterialApp(
          getPages: AppPage.list,
          initialRoute: AppRoute.mybottombar,
          debugShowCheckedModeBanner: false,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
