import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

AllProductsRequest allProductsRequestFromJson(String str) => AllProductsRequest.fromJson(json.decode(str));

String allProductsRequestToJson(AllProductsRequest data) => json.encode(data.toJson());

class AllProductsRequest {
    AllProductsRequest({
        this.page,
        this.norecord,
    });

    String page;
    String norecord;

    factory AllProductsRequest.fromJson(Map<String, dynamic> json) => AllProductsRequest(
        page: json["page"],
        norecord: json["norecord"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "norecord": norecord,
    };
}


AllProductsResponse allProductsResponseFromJson(String str) => AllProductsResponse.fromJson(json.decode(str));

String allProductsResponseToJson(AllProductsResponse data) => json.encode(data.toJson());

class AllProductsResponse {
    AllProductsResponse({
        this.status,
        this.code,
        this.productsCount,
        this.lastPage,
        this.data,
    });

    String status;
    int code;
    int productsCount;
    int lastPage;
    ProductsData data;

    factory AllProductsResponse.fromJson(Map<String, dynamic> json) => AllProductsResponse(
        status: json["status"],
        code: json["code"],
        productsCount: json["products_count"],
        lastPage: json["last_page"],
        data: ProductsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "products_count": productsCount,
        "last_page": lastPage,
        "data": data.toJson(),
    };
}

class ProductsData {
    ProductsData({
        this.products,
    });

    List<Product> products;

    factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.id,
        this.productName,
        this.mainImg,
        this.price,
        this.photo,
        this.noOfItems,
    });

    int id;
    String productName;
    String mainImg;
    String price;
    String photo;
    int noOfItems;

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


abstract class AllProductsRepository {
  Future<AllProductsResponse> getAllProducts(AllProductsRequest allProductsRequestBody,
      BuildContext context, http.Client client);
}