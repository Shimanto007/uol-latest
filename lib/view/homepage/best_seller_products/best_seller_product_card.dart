import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uol_new/model/best_seller_product.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/single_product/product_detail_screen.dart';

class BestSellerProductCard extends StatelessWidget {
  final BestSellerProducttList bestSellerProductList;
  const BestSellerProductCard({Key? key, required this.bestSellerProductList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageRouting.goToNextPage(
          context: context,
          navigateTo: ProductDetailScreen(
            productId: bestSellerProductList.id,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(10),
            width: 150,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: bestSellerProductList.images,
                    placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey,
                      child: Container(
                        color: Colors.grey,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      bestSellerProductList.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
                bestSellerProductList.Discount == 0 ? Container() : Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xFF0098B8)),
                  child: Text(
                    '${bestSellerProductList.Discount} Discount',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                    // maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                bestSellerProductList.finalProductPrice == bestSellerProductList.regularPrice ? Container(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          'BDT ' + bestSellerProductList.finalProductPrice.toString(),
                          style: TextStyle(
                              color: Color(0xFF0098B8),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ) :Container(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          'BDT ' + bestSellerProductList.finalProductPrice.toString(),
                          style: TextStyle(
                              color: Color(0xFF0098B8),
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: '  ',
                        ),
                        TextSpan(
                          text:
                          'BDT ' + bestSellerProductList.regularPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
