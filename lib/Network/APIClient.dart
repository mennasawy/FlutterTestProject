import 'dart:async';
import 'dart:io';
import 'package:flutter_test_project/Network/APIConstant.dart';
import 'package:flutter_test_project/Network/ErrorResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test_project/Model/SignIn.dart' as signInUser;
import 'package:flutter_test_project/Model/SignUp.dart' as signUpUser;
import 'package:flutter_test_project/Model/AllProducts.dart' as allProductsList;
import 'package:flutter_test_project/Model/ProductDetails.dart' as productDetails;

enum RequestType {
  SignUp,
  SignIn,
  ProductsList,
  ProductDetails,
}

dynamic getRequestBody(String requestBody) {
  return requestBody;
}

Future<dynamic> postCallService(String url, RequestType requestType,
    dynamic requestBody, http.Client client) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        print('Rrequest body ==== ${getRequestBody(requestBody)}');

        final response = await http
            .post('$url',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer'
                },
                body: getRequestBody(requestBody))
            .timeout(const Duration(seconds: 60));
        final statusCode = response.statusCode;
        print('Response === ${response.body}');

        if (statusCode != 200) {
          if (statusCode > 500 && statusCode < 599) {
            throw ErrorResponse(
                message: CODE_2, status: "statusCode:" + statusCode.toString());
          } else if (statusCode == 401) {
            var errorResponse = errorResponseFromJson(response.body);
            throw ErrorResponse(
                message: errorResponse.message, status: errorResponse.status);
          } else {
            var errorResponse = errorResponseFromJson(response.body);
            throw ErrorResponse(
                code: errorResponse.code,
                message: errorResponse.message,
                status: errorResponse.status);
          }
        }
        switch (requestType) {
          case RequestType.SignIn:
            signInUser.SignInResponse user =
                signInUser.loginResponseFromJson(response.body);
            if (user.code != 200) {
              throw ErrorResponse(code: user.code, message: user.message);
            }
            return user;
            break;
          case RequestType.SignUp:
            signUpUser.SignUpResponse user =
                signUpUser.signUpResponseFromJson(response.body);
            if (user.code != 200) {
              throw ErrorResponse(code: user.code, message: user.message);
            }
            return user;
            break;
          case RequestType.ProductsList:
            allProductsList.AllProductsResponse productsResponse =
                allProductsList.allProductsResponseFromJson(response.body);
            if (productsResponse.code != 200) {
              throw ErrorResponse(code: productsResponse.code, message: "Error while getting products");
            }
            return productsResponse;
            break;
          default:
            {}
        }
      } on NoSuchMethodError catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.toString() + " NoSuchMethodError");
      } on SocketException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + " SocketException");
      } on TimeoutException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + " TimeoutException");
      } on HandshakeException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + " HandshakeException");
      } on TypeError catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: '${e.toString()} TypeError');
      } on FormatException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + "formatException");
      }
    }
  } on SocketException catch (_) {
    throw ErrorResponse(message: CODE_1);
  }
}

String genericHandleErrorResponse(ErrorResponse errorResponse) {
  if (errorResponse.message == CODE_1) {
    return "There is no internet connection!";
  } else if (errorResponse.message == CODE_2) {
    return 'Server error check with Adminstrator! \n' + errorResponse.status;
  } else if (errorResponse.code != null &&
      errorResponse.code.toString() == CODE_401) {
    return 'Error ${errorResponse.message}';
  } else {
    return 'Invalid error ,try Again later ';
  }
}

Future<dynamic> getCallService(
    String url, RequestType requestType) async {
  logD('get url $url');
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        http.Response response = await http.get(url, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer',
        }).timeout(const Duration(seconds: 180));
        final statusCode = response.statusCode;
        logD('statusCode $statusCode');
        logD('response ${response.body}');
        if (statusCode != 200) {
          logD('error response ${response.body}');
          if (statusCode > 500 && statusCode < 599) {
            throw ErrorResponse(
                message: CODE_2, status: "statusCode:" + statusCode.toString());
          } else if (statusCode == 401) {
            var errorResponse = errorResponseFromJson(response.body);
            throw ErrorResponse(
                message: errorResponse.message, status: errorResponse.status);
          } else {
            var errorResponse = errorResponseFromJson(response.body);
            print('######## error is $errorResponse');
            throw ErrorResponse(
                code: errorResponse.code,
                // key: errorResponse.key,
                message: errorResponse.message,
                status: errorResponse.status);
          }
        }
        switch (requestType) {
          case RequestType.ProductDetails:
            productDetails.ProductDetails productResponse =
                productDetails.productDetailsFromJson(response.body);
            if (productResponse.code != 200) {
              throw ErrorResponse(code: productResponse.code, message: "Error while getting product data");
            }
            return productResponse;
            break;
          default:
            {}
        }
      } on NoSuchMethodError catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.toString() + " NoSuchMethodError");
      } on SocketException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + " SocketException");
      } on TimeoutException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + " TimeoutException");
      } on HandshakeException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + " HandshakeException");
      } on TypeError catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            // msg: CODE_2, data: '${e.toString()} TypeError'
            );
      } on FormatException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, status: e.message + "formatException");
      }
    }
  } on SocketException catch (_) {
    throw ErrorResponse(message: CODE_1);
  }
}
