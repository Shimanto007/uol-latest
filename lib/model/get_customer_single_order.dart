// To parse this JSON data, do
//
//     final getCustomerSingleOrder = getCustomerSingleOrderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCustomerSingleOrder getCustomerSingleOrderFromJson(String str) => GetCustomerSingleOrder.fromJson(json.decode(str));

String getCustomerSingleOrderToJson(GetCustomerSingleOrder data) => json.encode(data.toJson());

class GetCustomerSingleOrder {
    bool success;
    Data data;
    String message;
    int code;

    GetCustomerSingleOrder({
        required this.success,
        required this.data,
        required this.message,
        required this.code,
    });

    factory GetCustomerSingleOrder.fromJson(Map<String, dynamic> json) => GetCustomerSingleOrder(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
        "code": code,
    };
}

class Data {
    dynamic orderNumber;
    dynamic time;
    dynamic status;
    dynamic paymentMethod;
    dynamic paymentStatus;
    dynamic coupon;
    dynamic discount;
    dynamic shippingCharges;
    dynamic subtotal;
    dynamic payAmount;
    dynamic shippingName;
    dynamic shippingPhone;
    dynamic shippingEmail;
    dynamic shippingAddress;
    List<OrderDetail> orderDetails;

    Data({
        required this.orderNumber,
        required this.time,
        required this.status,
        required this.paymentMethod,
        required this.paymentStatus,
        required this.coupon,
        required this.discount,
        required this.shippingCharges,
        required this.subtotal,
        required this.payAmount,
        required this.shippingName,
        required this.shippingPhone,
        required this.shippingEmail,
        required this.shippingAddress,
        required this.orderDetails,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderNumber: json["order_number"],
        time: json["time"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        coupon: json["coupon"],
        discount: json["discount"],
        shippingCharges: json["shipping_charges"],
        subtotal: json["subtotal"],
        payAmount: json["pay_amount"],
        shippingName: json["shipping_name"],
        shippingPhone: json["shipping_phone"],
        shippingEmail: json["shipping_email"],
        shippingAddress: json["shipping_address"],
        orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_number": orderNumber,
        "time": time,
        "status": status,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "coupon": coupon,
        "discount": discount,
        "shipping_charges": shippingCharges,
        "subtotal": subtotal,
        "pay_amount": payAmount,
        "shipping_name": shippingName,
        "shipping_phone": shippingPhone,
        "shipping_email": shippingEmail,
        "shipping_address": shippingAddress,
        "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    };
}

class OrderDetail {
    dynamic id;
    dynamic orderId;
    dynamic productAttributeId;
    dynamic productName;
    dynamic productPrice;
    dynamic productQuantity;
    dynamic lineTotal;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic deletedAt;
    dynamic productUnitPrice;
    dynamic vatPercentage;
    dynamic productDiscount;

    OrderDetail({
        required this.id,
        required this.orderId,
        required this.productAttributeId,
        required this.productName,
        required this.productPrice,
        required this.productQuantity,
        required this.lineTotal,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.productUnitPrice,
        required this.vatPercentage,
        required this.productDiscount,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        orderId: json["order_id"],
        productAttributeId: json["product_attribute_id"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productQuantity: json["product_quantity"],
        lineTotal: json["line_total"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        productUnitPrice: json["product_unit_price"],
        vatPercentage: json["vat_percentage"],
        productDiscount: json["product_discount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_attribute_id": productAttributeId,
        "product_name": productName,
        "product_price": productPrice,
        "product_quantity": productQuantity,
        "line_total": lineTotal,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "product_unit_price": productUnitPrice,
        "vat_percentage": vatPercentage,
        "product_discount": productDiscount,
    };
}
