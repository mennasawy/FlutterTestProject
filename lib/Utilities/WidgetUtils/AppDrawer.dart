import 'package:flutter/material.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawerWidget extends StatefulWidget {
  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  var localStorage;
  String userName;
  String mobile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initShared();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Off_White,
                ),
                SizedBox(width: 10),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName ?? "",
                        style: basicWhiteTextStyle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        mobile ?? "",
                        style: basicWhiteTextStyle,
                      ),
                    ])
              ],
            ),
            decoration: BoxDecoration(
              color: Main_Purple,
            ),
          ),
          getMenuItem("Home", (){
            Navigator.pushNamed(context, HOME);
          }),
          getSeparatorWidget(context),
          getMenuItem("Sign Up", (){
            Navigator.of(context).pushReplacementNamed(SIGN_UP);
          }),
          getSeparatorWidget(context),
          getMenuItem("Sign In", (){
            Navigator.of(context).pushReplacementNamed(SIGN_IN);
          }),
          getSeparatorWidget(context),
          getMenuItem("Products", (){
            Navigator.pushNamed(context, ALL_PRODUCTS);
          }),
          getSeparatorWidget(context),
          getMenuItem("Shopping Cart", (){
            Navigator.pushNamed(context, HOME);
          }),
          getSeparatorWidget(context),
          getMenuItem("Sign Out", (){
            Navigator.of(context).pushReplacementNamed(SIGN_IN);
          }),
          getSeparatorWidget(context),
          getMenuItem("Dark Mode", (){}),
          getSeparatorWidget(context),
        ],
      ),
    );
  }

  Widget getMenuItem(String title, Function onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget getSeparatorWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        width: AppUtils.getScreenWidth(context),
        height: 0.5,
        color: Dark_Grey.withOpacity(0.2),
      ),
    );
  }

  Future initShared() async {
    localStorage = await SharedPreferences.getInstance();
    setState(() {
      userName = localStorage.getString('userName');
      mobile = localStorage.getString('mobile');
    });
  }
}
