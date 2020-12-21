import 'package:flutter_test_project/Model/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/Network/APIClient.dart';
import 'package:flutter_test_project/Utilities/URLConstants.dart';
import 'package:http/http.dart';

class ProductDetailsService implements ProductDetailsRepository {
  @override
  Future<ProductDetails> getProductDetailsWithID(int productID, BuildContext context, Client client) {
    // TODO: implement getProductDetailsWithID
    String url = URLConstants(context).productDetails + productID.toString();
    return getCallService(url, RequestType.ProductDetails);
  }
  
}