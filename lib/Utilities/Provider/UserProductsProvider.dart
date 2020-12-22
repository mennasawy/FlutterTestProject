import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';

class UserCartProductsProvider extends ChangeNotifier{
  List<Product>  _cartProductsList = [];
  List<Product>  _cartProductsListWithCount = [];

  List<Product> get cartProductsList => _cartProductsList;
  List<Product> get cartProductsListWithCount => _cartProductsListWithCount;

  set cartProductsList(List<Product> value) {
    _cartProductsList = value;
    notifyListeners();
  }

  set cartProductsListWithCount(List<Product> value) {
    _cartProductsListWithCount = value;
    notifyListeners();
  }

}