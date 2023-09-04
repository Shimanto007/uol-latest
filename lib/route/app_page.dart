import 'package:get/get.dart';
import 'package:uol_new/route/app_route.dart';
import 'package:uol_new/view/bottom_bar/my_bottom_bar.dart';
import 'package:uol_new/view/bottom_bar/mybottombar_binding.dart';
import 'package:uol_new/view/cart/cart_screen.dart';
import 'package:uol_new/view/checkout/shipping_detail_screen.dart';
import 'package:uol_new/view/homepage/home_page.dart';
import 'package:uol_new/view/homepage/homepage_binding.dart';
import 'package:uol_new/view/user_profile/user_profile_screen.dart';


class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.mybottombar,
        page: () => MyBottomBar(),
        binding: MybottombarBinding()
    ),
    GetPage(
        name: AppRoute.homepage,
        page: () => HomePage(),
        binding: HomepageBinding()
    ),
    GetPage(
        name: AppRoute.userProfileScreen,
        page: () => UserProfileScreen(),
        binding: HomepageBinding()
    ),
    GetPage(
        name: AppRoute.cartScreen,
        page: () => CartScreen(),
        binding: HomepageBinding()
    ),

  ];
}
