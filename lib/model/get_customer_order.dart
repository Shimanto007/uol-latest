// To parse this JSON data, do
//
//     final getCustomerOrders = getCustomerOrdersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetCustomerOrders> getCustomerOrdersFromJson(String str) => List<GetCustomerOrders>.from(json.decode(str).map((x) => GetCustomerOrders.fromJson(x)));

String getCustomerOrdersToJson(List<GetCustomerOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCustomerOrders {
    dynamic id;
    dynamic orderNumber;
    List<OrderDetail> orderDetails;
    dynamic totalQty;
    dynamic payAmount;
    dynamic paymentStatus;
    dynamic paymentMethod;
    dynamic status;
    dynamic orderNote;
    dynamic couponCode;
    dynamic couponDiscount;
    dynamic customerName;
    dynamic customerPhone;
    dynamic customerAddress;
    dynamic customerCity;
    dynamic customerZip;
    dynamic shippingName;
    dynamic shippingEmail;
    dynamic shippingPhone;
    dynamic shippingAddress;
    dynamic shippingCity;
    dynamic orderDateTime;

    GetCustomerOrders({
        required this.id,
        required this.orderNumber,
        required this.orderDetails,
        required this.totalQty,
        required this.payAmount,
        required this.paymentStatus,
        required this.paymentMethod,
        required this.status,
        required this.orderNote,
        required this.couponCode,
        required this.couponDiscount,
        required this.customerName,
        required this.customerPhone,
        required this.customerAddress,
        required this.customerCity,
        required this.customerZip,
        required this.shippingName,
        required this.shippingEmail,
        required this.shippingPhone,
        required this.shippingAddress,
        required this.shippingCity,
        required this.orderDateTime,
    });

    factory GetCustomerOrders.fromJson(Map<String, dynamic> json) => GetCustomerOrders(
        id: json["id"],
        orderNumber: json["order_number"],
        orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
        totalQty: json["totalQty"],
        payAmount: json["pay_amount"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        couponDiscount: json["coupon_discount"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        customerAddress: json["customer_address"],
        customerCity: json["customer_city\t"],
        customerZip: json["customer_zip"],
        shippingName: json["shipping_name"],
        shippingEmail: json["shipping_email"],
        shippingPhone: json["shipping_phone"],
        shippingAddress: json["shipping_address"],
        shippingCity: json["shipping_city"],
        orderDateTime: json["order_date_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
        "totalQty": totalQty,
        "pay_amount": payAmount,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "status": status,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "coupon_discount": couponDiscount,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "customer_address": customerAddress,
        "customer_city\t": customerCity,
        "customer_zip": customerZip,
        "shipping_name": shippingName,
        "shipping_email": shippingEmail,
        "shipping_phone": shippingPhone,
        "shipping_address": shippingAddress,
        "shipping_city": shippingCity,
        "order_date_time": orderDateTime,
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
    dynamic productUnitPrice;
    dynamic vatPercentage;
    dynamic deletedAt;
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
        required this.productUnitPrice,
        required this.vatPercentage,
        required this.deletedAt,
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
        productUnitPrice: json["product_unit_price"],
        vatPercentage: json["vat_percentage"],
        deletedAt: json["deleted_at"],
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
        "product_unit_price": productUnitPrice,
        "vat_percentage": vatPercentage,
        "deleted_at": deletedAt,
        "product_discount": productDiscount,
    };
}
