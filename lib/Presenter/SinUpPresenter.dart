import 'package:flutter/material.dart';
import 'package:flutter_test_project/DependencyInjector.dart';
import 'package:flutter_test_project/Model/SignIn.dart';
import 'package:flutter_test_project/Model/SignUp.dart';
import 'package:http/http.dart' as http;

abstract class SignUpContract {
  onSignUpSuccess(SignUpResponse signedInUser);
  onSignUpFailed(error);
}

class SignUpPresenter {
  SignUpContract signUpUserContract;
  SignUpRepository signUpRepositry;

  SignUpPresenter(this.signUpUserContract) {
    signUpRepositry = new Injector().signUpRepositry;
  }

  void userSignUp(SignUpRequest signUpRequestBody, BuildContext context) {
    print("Inside presenter");
    signUpRepositry
        .userSignUP(signUpRequestBody, context, http.Client())
        .then((c) => signUpUserContract.onSignUpSuccess(c))
        .catchError((onError) => signUpUserContract.onSignUpFailed(onError));
  }
}
