import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Network/APIClient.dart';
import 'package:flutter_test_project/Utilities/URLConstants.dart';
import 'package:http/http.dart';

class AllProductsService implements AllProductsRepository {
  @override
  Future<AllProductsResponse> getAllProducts(AllProductsRequest allProductsRequestBody, BuildContext context, Client client) async {
    // TODO: implement getAllProducts
     return await postCallService(URLConstants(context).allProducts,
        RequestType.ProductsList, allProductsRequestToJson(allProductsRequestBody), client);
  }
}
