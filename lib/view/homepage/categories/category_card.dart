import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uol_new/constant.dart';
import 'package:uol_new/model/category.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/category_products/category_product_screen.dart';


class CategoryCard extends StatelessWidget {
  final CategoryList category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  void selectCategory(BuildContext ctx) {
    PageRouting.goToNextPage(
      context: ctx,
      navigateTo: CategoryProductsScreen(
        categoryId: category.id,
        categoryTitle: category.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var categorysId = category.id;
    final imageUrl =  category.image;
    final imgUrl = imageUrl.toString();
    return GestureDetector(
      onTap: () => selectCategory(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: CachedNetworkImage(
          imageUrl: category.image,
          imageBuilder: (context, imageProvider) => Material(
            elevation: 5,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage('$imgUrl'),
                    width: 40,
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      category.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          placeholder: (context, url) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Material(
            elevation: 8,
            shadowColor: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
