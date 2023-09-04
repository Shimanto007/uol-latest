import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/category_products/category_product_screen.dart';



class AllCategoryItem extends StatelessWidget {
  final dynamic id;
  final dynamic category_name;
  final dynamic category_image;

  AllCategoryItem(
      this.id,
      this.category_name,
      this.category_image,
      );

  @override
  Widget build(BuildContext context) {
    // print(category_image);
    return GestureDetector(
      onTap: () {
        PageRouting.goToNextPage(
          context: context,
          navigateTo: CategoryProductsScreen(
            categoryId: id,
            categoryTitle: category_name,
          ),
        );
      },
      child: Container(

        margin: EdgeInsets.all(5),
        child: Material(
          elevation: 9,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: CachedNetworkImage(
                    imageUrl: '$category_image',

                    placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey,
                      child: Container(
                        color: Colors.grey,
                        padding: EdgeInsets.all(1),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                      // textAlign: TextAlign.center,
                      category_name,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
