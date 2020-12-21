import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
    ProductDetails({
        this.status,
        this.code,
        this.data,
    });

    String status;
    int code;
    ProductDetailsData data;

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        status: json["status"],
        code: json["code"],
        data: ProductDetailsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data.toJson(),
    };
}

class ProductDetailsData {
    ProductDetailsData({
        this.product,
    });

    List<Product> product;

    factory ProductDetailsData.fromJson(Map<String, dynamic> json) => ProductDetailsData(
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.id,
        this.productName,
        this.mainImg,
        this.price,
        this.photo,
    });

    int id;
    String productName;
    String mainImg;
    String price;
    String photo;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        mainImg: json["main_img"],
        price: json["price"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "main_img": mainImg,
        "price": price,
        "photo": photo,
    };
}

abstract class ProductDetailsRepository{
  Future<ProductDetails> getProductDetailsWithID(int productID, BuildContext context, http.Client client);
}