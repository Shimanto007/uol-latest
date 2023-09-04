import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'category_product_grid.dart';

class CategoryProductsScreen extends StatelessWidget {
  static const routeName = 'category-product';
  final int categoryId;
  final String categoryTitle;

  CategoryProductsScreen({
    required this.categoryTitle,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF0098B8),),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),

        title: Text(
          categoryTitle,
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
      // drawer: AppDrawer(),
      body: category_products_grid(categoryId: categoryId,),

    );
  }
}


