// To parse this JSON data, do
//
//     final categoryProduct = categoryProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryProduct categoryProductFromJson(String str) => CategoryProduct.fromJson(json.decode(str));

String categoryProductToJson(CategoryProduct data) => json.encode(data.toJson());

class CategoryProduct {
    bool success;
    Data data;
    String message;
    int code;

    CategoryProduct({
        required this.success,
        required this.data,
        required this.message,
        required this.code,
    });

    factory CategoryProduct.fromJson(Map<String, dynamic> json) => CategoryProduct(
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
    List<Datum> data;
    Links links;
    Meta meta;

    Data({
        required this.data,
        required this.links,
        required this.meta,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
    };
}

class Datum {
    dynamic id;
    dynamic name;
    dynamic slug;
    dynamic regularPrice;
    dynamic formattedRegularPrice;
    dynamic discount;
    dynamic discountedPrice;
    dynamic finalProductPrice;
    dynamic formattedFinalProductPrice;
    Image image;
    dynamic alterText;
    dynamic links;
    dynamic stock;
    dynamic isEnablePoint;

    Datum({
        required this.id,
        required this.name,
        required this.slug,
        required this.regularPrice,
        required this.formattedRegularPrice,
        required this.discount,
        required this.discountedPrice,
        required this.finalProductPrice,
        required this.formattedFinalProductPrice,
        required this.image,
        required this.alterText,
        required this.links,
        required this.stock,
        required this.isEnablePoint,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        regularPrice: json["regular_price"],
        formattedRegularPrice: json["formatted_regular_price"],
        discount: json["discount"],
        discountedPrice: json["discounted_price"],
        finalProductPrice: json["final_product_price"],
        formattedFinalProductPrice: json["formatted_final_product_price"],
        image: Image.fromJson(json["image"]),
        alterText: json["alter_text"],
        links: json["links"],
        stock: json["stock"],
        isEnablePoint: json["is_enable_point"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "regular_price": regularPrice,
        "formatted_regular_price": formattedRegularPrice,
        "discount": discount,
        "discounted_price": discountedPrice,
        "final_product_price": finalProductPrice,
        "formatted_final_product_price": formattedFinalProductPrice,
        "image": image.toJson(),
        "alter_text": alterText,
        "links": links,
        "stock": stock,
        "is_enable_point": isEnablePoint,
    };
}

class Image {
    String large;
    String medium;
    String small;

    Image({
        required this.large,
        required this.medium,
        required this.small,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
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

class Links {
    String first;
    String last;
    dynamic prev;
    dynamic next;

    Links({
        required this.first,
        required this.last,
        required this.prev,
        required this.next,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
    };
}

class Meta {
    int currentPage;
    int from;
    int lastPage;
    List<Link> links;
    String path;
    int perPage;
    int to;
    int total;

    Meta({
        required this.currentPage,
        required this.from,
        required this.lastPage,
        required this.links,
        required this.path,
        required this.perPage,
        required this.to,
        required this.total,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}

class Link {
    dynamic url;
    dynamic label;
    bool active;

    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
