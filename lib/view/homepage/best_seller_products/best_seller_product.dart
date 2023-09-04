import 'package:flutter/material.dart';
import 'package:uol_new/model/best_seller_product.dart';
import 'package:uol_new/view/homepage/best_seller_products/best_seller_product_card.dart';



class BestSellerProduct extends StatelessWidget {
  final List<BestSellerProducttList> bestSellerProducts;

  const BestSellerProduct({Key? key, required this.bestSellerProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 295,
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: bestSellerProducts.length,
        itemBuilder: (context, index) => BestSellerProductCard(
          bestSellerProductList: bestSellerProducts[index],
        ),
      ),
    );
  }
}
