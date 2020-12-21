import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test_project/Model/SignIn.dart';
import 'package:flutter_test_project/Network/APIClient.dart';
import 'package:flutter_test_project/Utilities/URLConstants.dart';
import 'package:http/src/client.dart';

class SignInService implements SignInRepository {
  @override
  Future<SignInResponse> userSignIn(SignInRequest loginRequestBody,
      BuildContext context, Client client) async {
    // TODO: implement userSignIn
    return await postCallService(URLConstants(context).signInURL,
        RequestType.SignIn, loginRequestToJson(loginRequestBody), client);
  }
}
