import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Model/ProductDetails.dart';
import 'package:flutter_test_project/Model/SignIn.dart';
import 'package:flutter_test_project/Model/SignUp.dart';
import 'package:flutter_test_project/Services/AllProductsService.dart';
import 'package:flutter_test_project/Services/ProductDetailsService.dart';
import 'package:flutter_test_project/Services/SignInService.dart';
import 'package:flutter_test_project/Services/SignUpService.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  SignInRepository get signInRepositry {
    return new SignInService();
  }

  SignUpRepository get signUpRepositry {
    return new SignUpService();
  }

  AllProductsRepository get allProductsRepositry{
    return new AllProductsService();
  }

  ProductDetailsRepository get productDetailsRepositry{
    return new ProductDetailsService();
  }
}
