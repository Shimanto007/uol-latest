import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uol_new/model/cart.dart';


class CartController extends GetxController {

  RxList<CartItem> cartItems = List<CartItem>.empty(growable: true).obs;

  double get cartTotal => cartItems.fold(0, (sum, item) => sum + ((item.price) * item.qty));

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
    emptyCart();
  }

    void emptyCart() {
    cartItems.clear();
    update();
    saveCartItems();
  }

  void addItemToCart(CartItem item) {
    bool itemExists = false;
    for (var cartItem in cartItems) {
      var checkId = cartItem.product_id.toString() + cartItem.variantId.toString();
      if (cartItem.product_id == item.product_id  && cartItem.variantId == item.variantId) {
        // cartItem.quantity += item.quantity;
        // saveCartItems();
        itemExists = true;
        update();
        break;
      }
    }
    if (!itemExists) cartItems.add(item);
    update();
    saveCartItems();
  }


  void removeItemFromCart(CartItem item) {
    cartItems.removeWhere((cartItem) => cartItem.product_id == item.product_id  && cartItem.variantId == item.variantId);
    update();
    saveCartItems();
  }

  Future<void> saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsList = cartItems.map((item) => item.toMap()).toList().map((e) => e.toString()).toList();
    await prefs.setStringList('cartItems', cartItemsList);
  }

  Future<void> loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsList = prefs.getStringList('cartItems');
    // print(cartItemsList);
  }
}