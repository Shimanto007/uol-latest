import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/all_category.dart';
import 'package:http/http.dart' as http;
import 'package:uol_new/model/category.dart';
import 'package:uol_new/view/category/all_category_item.dart';
import 'package:uol_new/view/category_products/category_product_loading_grid.dart';

class all_category_grid extends StatefulWidget {

  @override
  State<all_category_grid> createState() => _all_category_gridState();
}

class _all_category_gridState extends State<all_category_grid> {


  Future<AllCategory> getCategoryApi() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/get-categories'),
    );
    var data = jsonDecode(response.body);
    // print(data);
    if (response.statusCode == 200) {
      return AllCategory.fromJson(data);
    } else {
      return AllCategory.fromJson(data);
    }
  }

  @override
  void initState() {
    super.initState();
    // this.getCategoryApi();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getCategoryApi();
  }

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
          'All Categories',
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
      body: Container(
        padding: EdgeInsets.all(10),
        height: height,
        // child: Text('$categoryId')
        child: FutureBuilder<AllCategory>(
          future: getCategoryApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final allCategory = snapshot.data!.categories;
              // print(allCategory);
              return Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  // itemCount: allCategory.length,
                  itemCount: allCategory.length,
                  itemBuilder: (context, i) => AllCategoryItem(
                    // allCategory![i].id,
                    // allCategory![i].categoryName,
                    // allCategory[i].categoryImage,
                    allCategory![i].id,
                    allCategory![i].categoryName,
                    allCategory![i].categoryImage,
                  ),
                ),
              );
            } else {
              return CategoryProductLoadingGrid();
            }
          },
        ),
      ),
    );
  }
}
