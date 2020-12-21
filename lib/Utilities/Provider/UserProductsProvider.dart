import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';

class UserCartProducts extends ChangeNotifier{
  List<Product>  _cartProductsList;

  List<Product> get cartProductsList => _cartProductsList;

  set cartProductsList(List<Product> value) {
    _cartProductsList = value;
    notifyListeners();
  }

}