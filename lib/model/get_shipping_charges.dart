

import 'dart:convert';

GetShippingCharges getShippingChargesFromJson(String str) => GetShippingCharges.fromJson(json.decode(str));

String getShippingChargesToJson(GetShippingCharges data) => json.encode(data.toJson());

class GetShippingCharges {
  GetShippingCharges({
    required this.shippingCharges,
  });

  List<ShippingCharge> shippingCharges;

  factory GetShippingCharges.fromJson(Map<String, dynamic> json) => GetShippingCharges(
    shippingCharges: List<ShippingCharge>.from(json["shipping_charges"].map((x) => ShippingCharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shipping_charges": List<dynamic>.from(shippingCharges.map((x) => x.toJson())),
  };
}

class ShippingCharge {
  ShippingCharge({
    required this.id,
    required this.name,
    required this.price,
  });

  int id;
  String name;
  int price;

  factory ShippingCharge.fromJson(Map<String, dynamic> json) => ShippingCharge(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };
}
