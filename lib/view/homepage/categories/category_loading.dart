import 'package:flutter/material.dart';
import 'package:uol_new/view/homepage/categories/category_loading_card.dart';

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) => const CategoryLoadingCard(),
      ),
    );
  }
}
