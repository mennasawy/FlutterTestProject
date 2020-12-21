import 'dart:async';

class URLConstants{
  String baseURL;
  String signInURL;
  String signUpURL;
  String allProducts;
  String productDetails;
  URLConstants(context){
    baseURL = "http://phpstack-466670-1463298.cloudwaysapps.com/public/api";
    signInURL = baseURL + "/login";
    signUpURL = baseURL + "/signup";
    allProducts = baseURL + "/products_all";
    productDetails = baseURL + "/product_detail?product_id=";
  }
}