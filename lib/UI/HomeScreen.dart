import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/AppDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Main_Purple,
          actions: [Icon(Icons.shopping_cart), SizedBox(width: 10)],
        ),
        drawer: AppDrawerWidget(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getItemCardWidget("Products", () {
                Navigator.pushNamed(context, ALL_PRODUCTS);
              }),
              SizedBox(width: AppUtils.getScreenWidth(context) * 0.1),
              getItemCardWidget("Shopping Cart", () {
                Navigator.pushNamed(context, ALL_PRODUCTS);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget getItemCardWidget(String title, Function onTap) {
    return GestureDetector(
      child: Container(
        width: AppUtils.getScreenWidth(context) * 0.4,
        height: AppUtils.getScreenHeight(context) * 0.25,
        decoration: BoxDecoration(
            color: Main_Purple,
            borderRadius: BorderRadius.circular(10),
            border: Border(
              top: BorderSide(width: 2, color: Main_Purple.withOpacity(0.5)),
              bottom: BorderSide(width: 2, color: Main_Purple.withOpacity(0.5)),
              right: BorderSide(width: 2, color: Main_Purple.withOpacity(0.5)),
              left: BorderSide(width: 2, color: Main_Purple.withOpacity(0.5)),
            )),
        child: Center(
            child: Text(
          title,
          style: basicWhiteTextStyle,
        )),
      ),
      onTap: onTap,
    );
  }
}
