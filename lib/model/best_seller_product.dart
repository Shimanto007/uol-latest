import 'dart:convert';

List<BestSellerProducttList> bestSellerProductListFromJson(String val) =>
    List<BestSellerProducttList>.from(json.decode(val)["data"]["data"].map(
        (bestSellerProduct) =>
            BestSellerProducttList.bestSellerProductListFromJson(
                bestSellerProduct)));

class BestSellerProducttList {
  final int id;
  final String name;
  final String images;
  final int regularPrice;
  final dynamic finalProductPrice;
  final dynamic Discount;

  BestSellerProducttList({
    required this.id,
    required this.name,
    required this.images,
    required this.regularPrice,
    required this.finalProductPrice,
    required this.Discount,
  });

  factory BestSellerProducttList.bestSellerProductListFromJson(
          Map<String, dynamic> data) =>
      BestSellerProducttList(
        id: data['id'],
        name: data['name'],
        images: data['image']['small'],
        regularPrice: data['regular_price'],
        finalProductPrice: data['final_product_price'],
        Discount: data['discount'],
      );
}
