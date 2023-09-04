import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/controller/login_controller.dart';
import 'package:uol_new/view/authentication/login_screen.dart';
import 'package:uol_new/view/cart/cart_screen.dart';
import 'package:uol_new/view/category/all_category_screen.dart';
import 'package:uol_new/view/homepage/home_page.dart';
import 'package:uol_new/view/order/orders_screen.dart';
import 'package:uol_new/view/user_profile/user_profile_screen.dart';

class MyBottomBar extends StatefulWidget {
  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  final AuthController authController = Get.put(AuthController());
  final CartController cartController = Get.put(CartController());

  bool _isLoggedIn = false;
  int cartCount = 0;

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      // print(_isLoggedIn);
    });
  }

  void _checkCartCount() async {
    setState(() {
      cartCount = cartController.cartItems.length;
      cartController.cartTotal;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _checkCartCount();
    cartController.cartTotal;
  }

  @override
  Widget build(BuildContext context) {
    Route nextroute =
        MaterialPageRoute(builder: (context) => UserProfileScreen());
    Route nextrouteOrder =
        MaterialPageRoute(builder: (context) => OrdersScreen());
    Route nextrouteCart =
    MaterialPageRoute(builder: (context) => CartScreen());

    PersistentTabController _controller;
    List<Widget> _buildScreens() {
      return [
        HomePage(),
        all_category_grid(),
        Obx(() {
          if(authController.isLoggedIn == true) {
            return CartScreen();
          } else {
            return LoginPage(nextRoute: nextrouteCart);
          }
        }),
        Obx(() {
          if(authController.isLoggedIn == true) {
            return OrdersScreen();
          } else {
            return LoginPage(nextRoute: nextrouteOrder);
          }
        }),
        Obx(() {
          if(authController.isLoggedIn == true) {
            return UserProfileScreen();
          } else {
            return LoginPage(nextRoute: nextroute);
          }
        }),
        // _isLoggedIn ? OrdersScreen() : LoginPage(nextRoute: nextrouteOrder),
        // _isLoggedIn ? UserProfileScreen() : LoginPage(nextRoute: nextroute),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Color(0xFF0098B8),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.grid_view),
          title: ("All Categories"),
          activeColorPrimary: Color(0xFF0098B8),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          // icon: Icon(Icons.shopping_cart),
          icon: Obx(() {
            if(cartController.cartItems.length > 0){
              return Stack(
                children: [
                  Icon(Icons.shopping_cart),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${cartController.cartItems.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  Icon(Icons.shopping_cart),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
          title: ("Cart"),
          activeColorPrimary: Color(0xFF0098B8),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.add_shopping_cart),
          title: ("Orders"),
          activeColorPrimary: Color(0xFF0098B8),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("User"),
          activeColorPrimary: Color(0xFF0098B8),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
