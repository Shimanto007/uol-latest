import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/controller/cart_controller.dart';
import 'package:uol_new/controller/controller.dart';
import 'package:uol_new/model/cart.dart';
import 'package:uol_new/model/product_detail.dart';
import 'package:uol_new/view/homepage/best_seller_products/best_seller_product.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product_loading.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState(productId: productId);
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final int productId;
  _ProductDetailScreenState({
    required this.productId,
});
  final CartController cartController = Get.put(CartController());
  var _variantPrice = '';
  var _variantId = 0;
  var _variantValue = '';
  dynamic _variantStock = 0;
  var _variantFinalPrice = '';
  bool _isChecked = false;
  var selectedColor = '';

  Future<ProductDetail> getProductDetailApi() async {

    final response = await http.get(
      Uri.parse(
          '$baseUrl/get-product/$productId?platform=app'),
    );

    // final response = await http.get(
    //   Uri.parse(
    //       'http://192.168.100.63:8080/api/get-product/$productId'),
    // );

    var data = jsonDecode(response.body);
    // print(data);
    // print(productId);
    if (response.statusCode == 200) {
      return ProductDetail.fromJson(data);
    } else {
      return ProductDetail.fromJson(data);
    }
  }

  void onVariantSelected(String variantPrice) {
    setState(() {
      _variantPrice = _variantPrice;
    });
  }

  @override
  void initState() {
    getProductDetailApi();
    onVariantSelected(_variantPrice);
    super.initState();
  }

  int _selectedOptionIndex = 100;

  @override
  Widget build(BuildContext context) {
    int quantity = 1;

    void _showSuccessDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Succesfull',
            style: TextStyle(
              color: Color(0xFF0098B8),
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Okay',
                style: TextStyle(
                  color: Color(0xFF0098B8),
                ),
              ),
            )
          ],
        ),
      );
    }

    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Variant not Selected',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
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

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ProductDetail>(
            future: getProductDetailApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final singularProduct = snapshot.data!.data;
                // print(singularProduct.toString());
                List<String> imageList = List<String>.from(snapshot
                    .data!.data.multipleImages
                    .map((imageObject) => imageObject.image.small));
                // print(imageList);
                final attributes = snapshot.data!.data.attributes;
                final int quantity = 1;
                final String htmlCode = """${singularProduct.description}""";

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
                      statusBarBrightness:
                          Brightness.light, // For iOS (dark icons)
                    ),
                    title: Text(
                      'Ultimate Organic Life',
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
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 1 / 1,
                                viewportFraction: 1,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                              ),
                              items: imageList.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                              image,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              singularProduct.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0098B8),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "lato",
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Select Variant',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0098B8),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "lato",
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: attributes.length == 1 ? 100 : 200,
                            color: Colors.transparent,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: attributes.length == 1
                                    ? 1
                                    : attributes.length,
                                childAspectRatio: 9 / 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              padding: EdgeInsets.all(0),
                              itemCount: attributes.length,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                    color: _selectedOptionIndex == index
                                        ? Color(0xFF0098B8)
                                        : Colors.transparent,
                                    border: Border.all(
                                      width: 2,
                                      color: Color(0xFF0098b8),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _variantPrice =
                                          attributes[index].attributeFinalPrice.toString();
                                      _variantId = attributes[index].id;
                                      _variantValue =
                                          attributes[index].attributeValue;
                                      _variantStock = attributes[index].stock;
                                      _variantFinalPrice =
                                          attributes[index].attributeFinalPrice.toString();
                                      _selectedOptionIndex = index;
                                      // print(_selectedOptionIndex);
                                      onVariantSelected(_variantPrice);
                                    });
                                  },
                                  child: Container(
                                    child: Text(
                                      '${attributes[index].attributeValue}',
                                      style: TextStyle(
                                        color: _selectedOptionIndex == index
                                            ? Colors.white
                                            : Colors.grey.shade500,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              // 'BDT ${singularProduct.finalProductPrice}',
                              "BDT ${_variantPrice}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0098B8),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "lato",
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(0xFF0098b8),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "lato",
                                color: Color(0xFF0098B8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color(0xFF6ec588),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(bottom: 40),
                            child: HtmlWidget(
                              htmlCode,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Products You May Like',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0098B8),
                              ),
                            ),
                          ),
                          Obx(() {
                            if (homeController.popularProductsList.isNotEmpty) {
                              return PopularProduct(
                                popularProducts:
                                    homeController.popularProductsList,
                              );
                            } else {
                              return PopularProductLoading();
                            }
                          }),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Related Products',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0098B8),
                              ),
                            ),
                          ),
                          Obx(() {
                            if (homeController
                                .bestSellerProductsList.isNotEmpty) {
                              return BestSellerProduct(
                                bestSellerProducts:
                                    homeController.bestSellerProductsList,
                              );
                            } else {
                              return PopularProductLoading();
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: SizedBox(
                    height: 70,
                    width: 380,
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              double? variantPrice =
                                  double.tryParse(_variantPrice);
                              if (variantPrice == null) {
                                _showErrorDialog('Select Variant');
                              } else {
                                // print(singularProduct.id.toString());
                                final cartItem = CartItem(
                                  id: singularProduct.id.toString(),
                                  product_id: singularProduct.id.toString(),
                                  title: singularProduct.name,
                                  qty: 1,
                                  price: variantPrice,
                                  image: singularProduct.image.small,
                                  variantId: _variantId,
                                  variantValue: _variantValue,
                                  variantStock: _variantStock,
                                  variantFinalPrice: _variantFinalPrice,
                                  isEnablePoint: singularProduct.isEnablePoint,
                                );
                                Get.find<CartController>()
                                    .addItemToCart(cartItem);

                                _showSuccessDialog('Product added to the cart');
                              }
                            },
                            child: Text('Add to Cart'),
                            shape: Border(),
                            backgroundColor: Color(0xFF0098B8),
                          ),
                        )),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                );
              } else {
                return Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: Color(0xFF0098B8),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
