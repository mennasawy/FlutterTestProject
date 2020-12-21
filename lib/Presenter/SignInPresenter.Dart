import 'package:flutter/material.dart';
import 'package:flutter_test_project/DependencyInjector.dart';
import 'package:flutter_test_project/Model/SignIn.dart';
import 'package:http/http.dart' as http;

abstract class SignInContract {
  onSignInSuccess(SignInResponse signedInUser);
  onSignInFailed(error);
}

class SignInPresenter {
  SignInContract signInUserContract;
  SignInRepository signInRepositry;

  SignInPresenter(this.signInUserContract) {
    signInRepositry = new Injector().signInRepositry;
  }

  void userSignIn(SignInRequest loginRequestBody, BuildContext context) {
    print("Inside presenter");
    signInRepositry
        .userSignIn(loginRequestBody, context, http.Client())
        .then((c) => signInUserContract.onSignInSuccess(c))
        .catchError((onError) => signInUserContract.onSignInFailed(onError));
  }
}
