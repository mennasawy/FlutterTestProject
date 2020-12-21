import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/SignIn.dart';
import 'package:flutter_test_project/Presenter/SignInPresenter.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/RaisedButtonWidget.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/TextFieldWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> implements SignInContract {
  bool isSigningIn = false;
  String password = "";
  String mobileNumber = "";
  SignInResponse user;
  SignInPresenter _signInPresenter;

  var localStorage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initShared();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            getBackgroundWidget(),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFieldWidget(
                    hintText: "Mobile No.",
                    onValueChanged: (value) {
                      mobileNumber = value;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  getSeparatorWidget(context),
                  TextFieldWidget(
                      hintText: "Password",
                      onValueChanged: (value) {
                        password = value;
                      }),
                  SizedBox(height: 20),
                  getSignInButtonWidget(context)
                ]),
          ],
        ),
      ),
    );
  }

  // TODO: Widgets helping methods
  Padding getSeparatorWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: AppUtils.getScreenWidth(context) * 0.75,
        height: 0.5,
        color: Off_White,
      ),
    );
  }

  Container getSignInButtonWidget(BuildContext context) {
    return Container(
      width: AppUtils.getScreenWidth(context) * 0.8,
      height: 40,
      child: RaisedButtonWidget(
        buttonColor: White,
        buttonTitle: "Sign In",
        onButtonTap: !isSigningIn? onSignInPressed : null,
      ),
    );
  }

  Container getBackgroundWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Main_Purple,
            Main_Fuscia,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  //TODO: Handle sign in action
  onSignInPressed(){
    if(areInputsValid()){
      signIn();
    }
  }

  areInputsValid(){
    bool isValid = false;
    if(AppUtils.isNotEmptyText(mobileNumber) && AppUtils.isValidPhoneNumber(mobileNumber)){
      if(AppUtils.isNotEmptyText(password)){
        isValid = true;
      } else AppUtils.showToast("Enter Your Password");
    } else AppUtils.showToast("Enter Valid Mobile Number");
    return isValid;
  }

  signIn(){
    SignInRequest signInRequestBody = SignInRequest(mobile: mobileNumber, password: password);
    _signInPresenter = SignInPresenter(this);
    _signInPresenter.userSignIn(signInRequestBody, context);
    setState(() {
      isSigningIn = true;
    });
  }

  @override
  onSignInFailed(error) {
    // TODO: implement onSignInFailed
    setState(() {
      isSigningIn = false;
    });
    AppUtils.showToast(error.message);
  }

  @override
  onSignInSuccess(SignInResponse signedInUser) {
    // TODO: implement onSignInSuccess
    user = signedInUser;
    setState(() {
      isSigningIn = false;
    });
    AppUtils.showToast(signedInUser.message);
    saveUserToSharedPreferences(signedInUser);
  }

  saveUserToSharedPreferences(SignInResponse user){
    localStorage.setString('userName', user.data.nameEn.toString());
    localStorage.setString('mobile', user.data.mobile.toString());
  }

  Future initShared() async {
    localStorage = await SharedPreferences.getInstance();
  }
}
