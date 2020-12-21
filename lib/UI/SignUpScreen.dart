import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/SignUp.dart';
import 'package:flutter_test_project/Presenter/SinUpPresenter.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/RaisedButtonWidget.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/TextFieldWidget.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> implements SignUpContract {
  bool isSigningUp = false;
  SignUpPresenter _signUpPresenter;
  var selectedDate = new HijriCalendar.now();
  String userEnglishName, userArabicName, hijriBirthDate, mobile, password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            getBackgroundWidget(),
            Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //
                      TextFieldWidget(
                        hintText: "Your Name in English",
                        onValueChanged: (value) {
                          userEnglishName = value;
                        },
                      ),
                      getSeparatorWidget(context),
                      TextFieldWidget(
                        hintText: "Your Name in Arabic",
                        onValueChanged: (value) {
                          userArabicName = value;
                        },
                      ),
                      getSeparatorWidget(context),
                      TextFieldWidget(
                        hintText: "Hijri Date of Birth",
                        onFieldTap: () => _selectDate(context),
                        value: hijriBirthDate,
                      ),
                      getSeparatorWidget(context),
                      TextFieldWidget(
                        hintText: "Mobile",
                        onValueChanged: (value) {
                          mobile = value;
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      getSeparatorWidget(context),
                      TextFieldWidget(
                        hintText: "Password",
                        onValueChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 20),
                      getSignUpButtonWidget(context)
                    ]),
              ),
            ),
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

  Container getSignUpButtonWidget(BuildContext context) {
    return Container(
      width: AppUtils.getScreenWidth(context) * 0.8,
      height: 40,
      child: RaisedButtonWidget(
        buttonColor: White,
        buttonTitle: "Sign Up",
        onButtonTap: !isSigningUp ? onSignUpPressed : null,
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
  onSignUpPressed() {
    // if (AppUtils.isNotEmptyText(userEnglishName)) {
    //   if (AppUtils.isArabicText(userArabicName ?? "")) {
        SignUpRequest signUpRequestBody = SignUpRequest(
            nameEn: userEnglishName,
            nameAr: userArabicName,
            birthdate: hijriBirthDate,
            mobile: mobile,
            password: password);
        _signUpPresenter = SignUpPresenter(this);
        _signUpPresenter.userSignUp(signUpRequestBody, context);
        setState(() {
          isSigningUp = true;
        });
    //   } else
    //     AppUtils.showToast("Arabic User Name Must Be In Arabic Letters");
    // } else AppUtils.showToast("Name is required");
  }

  Future<Null> _selectDate(BuildContext context) async {
    final HijriCalendar picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: new HijriCalendar()
        ..hYear = 1445
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        hijriBirthDate = selectedDate.toString();
      });
  }

  @override
  onSignUpFailed(error) {
    // TODO: implement onSignUpFailed
    AppUtils.showToast(error.message);
    setState(() {
      isSigningUp = false;
    });
  }

  @override
  onSignUpSuccess(SignUpResponse signedInUser) {
    // TODO: implement onSignUpSuccess
    AppUtils.showToast(signedInUser.message);
    setState(() {
      isSigningUp = false;
    });
  }
}
