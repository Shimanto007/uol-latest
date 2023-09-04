import 'package:flutter/material.dart';
import 'package:uol_new/model/popular_product.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product_card.dart';


class PopularProduct extends StatelessWidget {
  final List<PopularProductList> popularProducts;

  const PopularProduct({Key? key, required this.popularProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 295,
      margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: popularProducts.length,
        itemBuilder: (context, index) => PopularProductCard(
          popularProductList: popularProducts[index],
        ),
      ),
    );
  }
}
