import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uol_new/view/app_drawer/app_drawer.dart';
import 'package:uol_new/view/homepage/banner/carousel_loading.dart';
import 'package:uol_new/view/homepage/banner/carousel_slider_view.dart';
import 'package:uol_new/view/homepage/best_seller_products/best_seller_product.dart';
import 'package:uol_new/view/homepage/categories/category.dart';
import 'package:uol_new/view/homepage/categories/category_loading.dart';
import 'package:uol_new/controller/controller.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product_loading.dart';


class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          child: Column(
            children: [
              Obx(() {
                if(homeController.bannerList.isNotEmpty) {
                  return CarouselSliderView(
                    bannerList: homeController.bannerList
                  );
                } else {
                  return CarouselLoading();
                }
              }),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                    'SHOP BY CATEGORIES',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0098B8),
                  ),
                ),
              ),
              Obx(() {
                if (homeController.categoryList.isNotEmpty) {
                  return Category(
                    categories: homeController.categoryList,
                  );
                } else {
                  return CategoryLoading();
                }
              }),

              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'POPULAR PRODUCTS',
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
                    popularProducts: homeController.popularProductsList,
                  );
                } else {
                  return PopularProductLoading();
                }
              }),

              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'BEST SELLER PRODUCTS',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0098B8),
                  ),
                ),
              ),

              Obx(() {
                if (homeController.bestSellerProductsList.isNotEmpty) {
                  return BestSellerProduct(
                    bestSellerProducts: homeController.bestSellerProductsList,
                  );
                } else {
                  return PopularProductLoading();
                }
              }),
            ],
          ),
        ),
        drawer: AppDrawer(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
