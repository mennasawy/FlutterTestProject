import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/SignUp.dart';
import 'package:flutter_test_project/Network/APIClient.dart';
import 'package:flutter_test_project/Utilities/URLConstants.dart';
import 'package:http/http.dart';

class SignUpService implements SignUpRepository {
  @override
  Future<SignUpResponse> userSignUP(SignUpRequest signUpRequestBody,
      BuildContext context, Client client) async {
    // TODO: implement userSignIn
    return await postCallService(URLConstants(context).signUpURL,
        RequestType.SignUp, signUpRequestToJson(signUpRequestBody), client);
  }
}
