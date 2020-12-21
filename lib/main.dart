import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_project/UI/AllProductsScreen.dart';
import 'package:flutter_test_project/UI/HomeScreen.dart';
import 'package:flutter_test_project/UI/ShoppingCartScreen.dart';
import 'package:flutter_test_project/UI/SignInScreen.dart';
import 'package:flutter_test_project/UI/SignUpScreen.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/Provider/DarkThemeProvider.dart';
import 'package:flutter_test_project/Utilities/Provider/UserProductsProvider.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/Styles.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserCartProductsProvider()),
        ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
      ],
      child: KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'),
                const Locale('ar', 'SA'),
              ],
              initialRoute: SIGN_IN,
              routes: {
                SIGN_IN: (context) => SignInScreen(),
                SIGN_UP: (context) => SignUpScreen(),
                ALL_PRODUCTS: (context) => AllProductsScreen(),
                HOME: (context) => HomeScreen(),
                SHOPPING_CART: (context) => ShoppingCartScreen(),
              },
            );
          },
        ),
      ),
    );
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }
}
