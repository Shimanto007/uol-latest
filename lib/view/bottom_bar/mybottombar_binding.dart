import 'package:get/get.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/controller/home_controller.dart';
import 'package:uol_new/controller/login_controller.dart';

class MybottombarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(CartController());
    Get.put(AuthController());
  }
}