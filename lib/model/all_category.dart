// To parse this JSON data, do
//
//     final allCategory = allCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllCategory allCategoryFromJson(String str) => AllCategory.fromJson(json.decode(str));

String allCategoryToJson(AllCategory data) => json.encode(data.toJson());

class AllCategory {
    List<Category> categories;

    AllCategory({
        required this.categories,
    });

    factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    String categoryName;
    String categoryImage;

    Category({
        required this.id,
        required this.categoryName,
        required this.categoryImage,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
    };
}
