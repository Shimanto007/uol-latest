import 'dart:convert';

List<PopularProductList> popularProductListFromJson(String val) =>
    List<PopularProductList>.from(json.decode(val)['data'].map(
            (popularProduct) =>
            PopularProductList.popularProductFromJson(popularProduct)));

class PopularProductList {
  final int id;
  final String name;
  final String images;
  final int regularPrice;
  final dynamic finalProductPrice;
  final dynamic Discount;

  PopularProductList({required this.id,
    required this.name,
    required this.images,
    required this.regularPrice,
    required this.finalProductPrice,
    required this.Discount,
  });

  factory PopularProductList.popularProductFromJson(
      Map<String, dynamic> data) =>
      PopularProductList(
        id: data['id'],
        name: data['name'],
        images: data['image']['small'],
        regularPrice: data['regular_price'],
        finalProductPrice: data['final_product_price'],
        Discount: data['discount'],
      );
}
