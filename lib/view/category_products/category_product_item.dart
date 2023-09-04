import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uol_new/route/routes.dart';
import 'package:uol_new/view/single_product/product_detail_screen.dart';



class ProductItem extends StatelessWidget {
  final dynamic id;
  final String product_name;
  final dynamic product_image;
  final dynamic regularPrice;
  final dynamic finalProductPrice;
  final dynamic appDiscount;

  ProductItem(
      this.id,
      this.product_name,
      this.product_image,
      this.regularPrice,
      this.finalProductPrice,
      this.appDiscount
      );

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context, listen:false);
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        PageRouting.goToNextPage(
          context: context,
          navigateTo: ProductDetailScreen(
            productId: id,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Material(
          elevation: 9,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: product_image,
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 35,
                    child: Text(
                        textAlign: TextAlign.center,
                        product_name,
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
                appDiscount == 0 ? Container() : Container(
                  padding: EdgeInsets.all(3),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xFF0098B8)),
                  child: Center(
                    child: Text(
                      'Discount ${appDiscount}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                      // maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                finalProductPrice == regularPrice ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        'BDT ' + finalProductPrice.toString(),
                        style: TextStyle(
                            color: Color(0xFF0098B8),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ) :RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        'BDT ' + finalProductPrice.toString(),
                        style: TextStyle(
                            color: Color(0xFF0098B8),
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: '  ',
                      ),
                      TextSpan(
                        text:
                        'BDT ' + regularPrice.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ],
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
