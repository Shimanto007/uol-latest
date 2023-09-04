import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/category_products.dart';
import 'package:uol_new/view/category_products/category_product_item.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/view/category_products/category_product_loading_card.dart';
import 'package:uol_new/view/category_products/category_product_loading_grid.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product_loading.dart';

class category_products_grid extends StatefulWidget {
  final int categoryId;

  category_products_grid({required this.categoryId});

  @override
  State<category_products_grid> createState() =>
      _category_products_gridState(categoryId: categoryId);
}

class _category_products_gridState extends State<category_products_grid> {
  final int categoryId;

  _category_products_gridState({required this.categoryId});

  Future<CategoryProduct> getAllCategoryApi() async {
    // print(categoryId);
    var client = http.Client();
    final url =
        '$baseUrl/get-category-products/$categoryId?limit=100&platform=app';
    final response = await client.get(
      Uri.parse(
          '$baseUrl/get-category-products/$categoryId?limit=100&platform=app'),
    );
    var data = jsonDecode(response.body);
    // print(data);
    if (response.statusCode == 200) {
      return CategoryProduct.fromJson(data);
    } else {
      return CategoryProduct.fromJson(data);
    }
  }

  @override
  void initState() {
    super.initState();
    // this.getAllCategoryApi();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getAllCategoryApi();
  }

  @override
  Widget build(BuildContext context) {
    // final String url = 'https://ultimateasiteapi.com/api/get-category-products/$categoryId';
    // print(url);
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      height: height,
      // child: Text('$categoryId')
      child: FutureBuilder<CategoryProduct>(
        future: getAllCategoryApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categoriesProduct = snapshot.data!.data.data;
            // print(categoriesProduct);
            return Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.63,
                ),
                itemCount: categoriesProduct!.length,
                itemBuilder: (context, i) => ProductItem(
                  categoriesProduct![i].id,
                  categoriesProduct![i].name,
                  categoriesProduct[i].image.small,
                  categoriesProduct[i].regularPrice,
                  categoriesProduct[i].finalProductPrice,
                  categoriesProduct[i].discount,
                ),
              ),
            );
          } else {
            final categoriesProduct = snapshot.data;
            return Container(
              height: 100,
                child: CategoryProductLoadingGrid(),
            );
          }
        },
      ),
    );
  }
}
