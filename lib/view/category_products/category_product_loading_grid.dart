import 'package:flutter/material.dart';
import 'package:uol_new/view/category_products/category_product_loading_card.dart';

class CategoryProductLoadingGrid extends StatelessWidget {
  const CategoryProductLoadingGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2/3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(10),
      itemCount: 6,
      itemBuilder: (context, index) => CategoryProductLoadingCard(),
    );
  }
}
