import 'package:flutter/material.dart';
import 'package:flutter_test_project/DependencyInjector.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Model/SignIn.dart';
import 'package:http/http.dart' as http;

abstract class AllProductsContract {
  onGetProductsSuccess(AllProductsResponse allProductsList);
  onGetProductsFailed(error);
}

class AllProductsPresenter {
  AllProductsContract allProductsContract;
  AllProductsRepository allProductsRepository;

  AllProductsPresenter(this.allProductsContract) {
    allProductsRepository = new Injector().allProductsRepositry;
  }

  void getAllProductsList(AllProductsRequest allProductsRequestBody, BuildContext context) {
    print("Inside presenter");
    allProductsRepository
        .getAllProducts(allProductsRequestBody, context, http.Client())
        .then((c) => allProductsContract.onGetProductsSuccess(c))
        .catchError((onError) => allProductsContract.onGetProductsFailed(onError));
  }
}
