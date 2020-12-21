import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_project/UI/AllProductsScreen.dart';
import 'package:flutter_test_project/UI/HomeScreen.dart';
import 'package:flutter_test_project/UI/SignInScreen.dart';
import 'package:flutter_test_project/UI/SignUpScreen.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/Provider/UserProductsProvider.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => UserCartProducts()),
      ],
      child: KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
           localizationsDelegates: [
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
           ],
           supportedLocales: [
             const Locale('en', 'US'),
             const Locale('ar', 'SA'),
           ],
          initialRoute: HOME,
          routes: {
            SIGN_IN: (context) => SignInScreen(),
            SIGN_UP: (context) => SignUpScreen(),
            ALL_PRODUCTS: (context) => AllProductsScreen(),
            HOME: (context) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
