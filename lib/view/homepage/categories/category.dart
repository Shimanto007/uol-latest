import 'package:flutter/material.dart';
import 'package:uol_new/model/category.dart';
import 'category_card.dart';

class Category extends StatelessWidget {
  final List<CategoryList> categories;

  const Category({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryCard(
          category: categories[index],
        ),
      ),
    );
  }
}
