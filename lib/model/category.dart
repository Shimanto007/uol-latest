import 'dart:convert';

List<CategoryList> categoryListFromJson(String val) => List<CategoryList>.from(json
    .decode(val)['categories']
    .map((category) => CategoryList.FromJson(category)));

class CategoryList {
  final int id;
  final String name;
  final String image;

  CategoryList({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryList.FromJson(Map<String, dynamic> data) => CategoryList(
        id: data['id'],
        name: data['category_name'],
        image: data['category_image'],
      );
}
