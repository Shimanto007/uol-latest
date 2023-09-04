import 'package:flutter/material.dart';
import 'package:uol_new/view/homepage/popular_product/popular_product_loading_card.dart';

class PopularProductLoading extends StatelessWidget {
  const PopularProductLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) => const PopularProductLoadingCard(),
      ),
    );
  }
}
