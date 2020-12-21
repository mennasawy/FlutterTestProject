import 'package:flutter/material.dart';
import 'package:flutter_test_project/DependencyInjector.dart';
import 'package:flutter_test_project/Model/ProductDetails.dart';
import 'package:http/http.dart' as http;

abstract class ProductDetailsContract {
  onGetProductDetailsSuccess(ProductDetails productDetails);
  onGetProductDetailssFailed(error);
}

class ProductDetailsPresenter {
  ProductDetailsContract productDetailsContract;
  ProductDetailsRepository productDetailsRepository;

  ProductDetailsPresenter(this.productDetailsContract) {
    productDetailsRepository = new Injector().productDetailsRepositry;
  }

  void getProductDetails(int productID, BuildContext context) {
    print("Inside presenter");
    productDetailsRepository
        .getProductDetailsWithID(productID, context, http.Client())
        .then((c) => productDetailsContract.onGetProductDetailsSuccess(c))
        .catchError((onError) => productDetailsContract.onGetProductDetailssFailed(onError));
  }
}
