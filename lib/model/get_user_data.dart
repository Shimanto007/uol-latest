// To parse this JSON data, do
//
//     final getUserData = getUserDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUserData getUserDataFromJson(String str) => GetUserData.fromJson(json.decode(str));

String getUserDataToJson(GetUserData data) => json.encode(data.toJson());

class GetUserData {
    dynamic customerId;
    dynamic customerName;
    dynamic customerEmail;
    dynamic customerContact;
    dynamic customerDob;
    dynamic customerGender;
    List<CustomerAddress> customerAddresses;
    dynamic loyaltyPoints;

    GetUserData({
        required this.customerId,
        required this.customerName,
        required this.customerEmail,
        required this.customerContact,
        required this.customerDob,
        required this.customerGender,
        required this.customerAddresses,
        required this.loyaltyPoints,
    });

    factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerContact: json["customer_contact"],
        customerDob: json["customer_dob"],
        customerGender: json["customer_gender"],
        customerAddresses: List<CustomerAddress>.from(json["customer_addresses"].map((x) => CustomerAddress.fromJson(x))),
        loyaltyPoints: json["loyalty_points"],
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_contact": customerContact,
        "customer_dob": customerDob,
        "customer_gender": customerGender,
        "customer_addresses": List<dynamic>.from(customerAddresses.map((x) => x.toJson())),
        "loyalty_points": loyaltyPoints,
    };
}

class CustomerAddress {
    dynamic id;
    dynamic customerId;
    dynamic name;
    dynamic email;
    dynamic phone;
    dynamic address;
    dynamic shippingId;
    dynamic areaId;
    dynamic area;
    dynamic zip;
    dynamic isDefault;
    dynamic createdAt;
    dynamic updatedAt;

    CustomerAddress({
        required this.id,
        required this.customerId,
        required this.name,
        required this.email,
        required this.phone,
        required this.address,
        required this.shippingId,
        required this.areaId,
        required this.area,
        required this.zip,
        required this.isDefault,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CustomerAddress.fromJson(Map<String, dynamic> json) => CustomerAddress(
        id: json["id"],
        customerId: json["customer_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        shippingId: json["shipping_id"],
        areaId: json["area_id"],
        area: json["area"],
        zip: json["zip"],
        isDefault: json["is_default"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "shipping_id": shippingId,
        "area_id": areaId,
        "area": area,
        "zip": zip,
        "is_default": isDefault,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
