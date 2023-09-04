class CartItem {
  final String id;
  final String product_id;
  final String title;
  int qty;
  final double price;
  final String image;
  final int variantId;
  final String variantValue;
  final dynamic variantStock;
  final String variantFinalPrice;
  final dynamic isEnablePoint;

  CartItem({
    required this.id,
    required this.product_id,
    required this.title,
    this.qty = 1,
    required this.price,
    required this.image,
    required this.variantId,
    required this.variantValue,
    required this.variantStock,
    required this.variantFinalPrice,
    required this.isEnablePoint,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['variantValue'],
      product_id: json['product_id'],
      title: json['title'],
      qty: json['qty'],
      price: json['price'],
      image: json['image'],
      variantId: json['variantId'],
      variantValue: json['variantValue'],
      variantStock: json['variantStock'],
      variantFinalPrice: json['variantFinalPrice'],
      isEnablePoint: json['is_enable_point'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': variantValue,
    'product_id': product_id,
    'product_name': title,
    'product_price': price,
    'qty': qty,
    'image': image,
    'variation_id': variantId,
    'variation_value': variantValue,
    'variation_stock': variantStock,
    'variation_final_price': variantFinalPrice,
    'is_enable_point': isEnablePoint,
  };

  Map<String, dynamic> toMap() => {
    'id': variantValue,
    'product_id': product_id,
    'product_name': title,
    'product_price': price,
    'qty': qty,
    'image': image,
    'variation_id': variantId,
    'variation_value': variantValue,
    'variation_stock': variantStock,
    'variation_final_price': variantFinalPrice,
    'is_enable_point': isEnablePoint,
  };

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['variation_value'],
      product_id: map['product_id'],
      title: map['product_name'],
      qty: map['qty'],
      price: map['product_price'],
      image: map['image'] ?? '',
      variantId: map['variation_id'],
      variantValue: map['variation_value'],
      variantStock: map['variation_stock'],
      variantFinalPrice: map['variation_final_price'],
      isEnablePoint: map['is_enable_point']
    );
  }
}
