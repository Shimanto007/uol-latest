// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
    bool success;
    Data data;
    String message;
    int code;

    ProductDetail({
        required this.success,
        required this.data,
        required this.message,
        required this.code,
    });

    factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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
    dynamic id;
    dynamic name;
    dynamic slug;
    dynamic category;
    dynamic categoryId;
    dynamic regularPrice;
    dynamic formattedRegularPrice;
    dynamic discount;
    dynamic discountedPrice;
    dynamic finalProductPrice;
    dynamic formattedFinalProductPrice;
    dynamic image;
    dynamic alterText;
    List<Image> multipleImages;
    dynamic video;
    dynamic description;
    dynamic shortDescription;
    dynamic links;
    dynamic stock;
    dynamic color;
    dynamic size;
    dynamic weight;
    dynamic tags;
    dynamic brand;
    List<Attribute> attributes;
    dynamic metaTitle;
    dynamic metaDescription;
    dynamic metaKeywords;
    int isEnablePoint;

    Data({
        required this.id,
        required this.name,
        required this.slug,
        required this.category,
        required this.categoryId,
        required this.regularPrice,
        required this.formattedRegularPrice,
        required this.discount,
        required this.discountedPrice,
        required this.finalProductPrice,
        required this.formattedFinalProductPrice,
        required this.image,
        required this.alterText,
        required this.multipleImages,
        required this.video,
        required this.description,
        required this.shortDescription,
        required this.links,
        required this.stock,
        required this.color,
        required this.size,
        required this.weight,
        required this.tags,
        required this.brand,
        required this.attributes,
        required this.metaTitle,
        required this.metaDescription,
        required this.metaKeywords,
        required this.isEnablePoint,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        category: json["category"],
        categoryId: json["category_id"],
        regularPrice: json["regular_price"],
        formattedRegularPrice: json["formatted_regular_price"],
        discount: json["discount"],
        discountedPrice: json["discounted_price"],
        finalProductPrice: json["final_product_price"],
        formattedFinalProductPrice: json["formatted_final_product_price"],
        image: ImageClass.fromJson(json["image"]),
        alterText: json["alter_text"],
        multipleImages: List<Image>.from(json["multiple_images"].map((x) => Image.fromJson(x))),
        video: json["video"],
        description: json["description"],
        shortDescription: json["short_description"],
        links: json["links"],
        stock: json["stock"],
        color: json["color"],
        size: json["size"],
        weight: json["weight"],
        tags: json["tags"],
        brand: json["brand"],
        attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        isEnablePoint: json["is_enable_point"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "category": category,
        "category_id": categoryId,
        "regular_price": regularPrice,
        "formatted_regular_price": formattedRegularPrice,
        "discount": discount,
        "discounted_price": discountedPrice,
        "final_product_price": finalProductPrice,
        "formatted_final_product_price": formattedFinalProductPrice,
        "image": image.toJson(),
        "alter_text": alterText,
        "multiple_images": List<dynamic>.from(multipleImages.map((x) => x.toJson())),
        "video": video,
        "description": description,
        "short_description": shortDescription,
        "links": links,
        "stock": stock,
        "color": color,
        "size": size,
        "weight": weight,
        "tags": tags,
        "brand": brand,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "is_enable_point": isEnablePoint,
    };
}

class Attribute {
    dynamic id;
    dynamic productId;
    dynamic attributeName;
    dynamic attributeValue;
    dynamic attributePrice;
    dynamic productDiscount;
    dynamic stock;
    dynamic productSku;
    dynamic attributeFinalPrice;
    dynamic defaultAttribute;
    dynamic status;
    dynamic attributeAlterText;
    dynamic isEnablePoint;
    dynamic createdAt;
    dynamic updatedAt;
    List<Image> productImages;

    Attribute({
        required this.id,
        required this.productId,
        required this.attributeName,
        required this.attributeValue,
        required this.attributePrice,
        required this.productDiscount,
        required this.stock,
        required this.productSku,
        required this.attributeFinalPrice,
        required this.defaultAttribute,
        required this.status,
        required this.attributeAlterText,
        required this.isEnablePoint,
        required this.createdAt,
        required this.updatedAt,
        required this.productImages,
    });

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        productId: json["product_id"],
        attributeName: json["attribute_name"],
        attributeValue: json["attribute_value"],
        attributePrice: json["attribute_price"],
        productDiscount: json["product_discount"],
        stock: json["stock"],
        productSku: json["product_sku"],
        attributeFinalPrice: json["attribute_final_price"],
        defaultAttribute: json["default_attribute"],
        status: json["status"],
        attributeAlterText: json["attribute_alter_text"],
        isEnablePoint: json["is_enable_point"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        productImages: List<Image>.from(json["product_images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "attribute_name": attributeName,
        "attribute_value": attributeValue,
        "attribute_price": attributePrice,
        "product_discount": productDiscount,
        "stock": stock,
        "product_sku": productSku,
        "attribute_final_price": attributeFinalPrice,
        "default_attribute": defaultAttribute,
        "status": status,
        "attribute_alter_text": attributeAlterText,
        "is_enable_point": isEnablePoint,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
    };
}

class Image {
    dynamic id;
    dynamic productId;
    dynamic productAttributeId;
    dynamic image;
    dynamic status;
    dynamic createdAt;
    dynamic updatedAt;

    Image({
        required this.id,
        required this.productId,
        required this.productAttributeId,
        required this.image,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        productAttributeId: json["product_attribute_id"],
        image: ImageClass.fromJson(json["image"]),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_attribute_id": productAttributeId,
        "image": image.toJson(),
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class ImageClass {
    String large;
    String medium;
    String small;

    ImageClass({
        required this.large,
        required this.medium,
        required this.small,
    });

    factory ImageClass.fromJson(Map<String, dynamic> json) => ImageClass(
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
    );

    Map<String, dynamic> toJson() => {
        "large": large,
        "medium": medium,
        "small": small,
    };
}
