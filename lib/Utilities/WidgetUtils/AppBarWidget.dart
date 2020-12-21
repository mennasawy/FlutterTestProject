import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/Provider/UserProductsProvider.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title; 

  @override
  final Size preferredSize;

  AppBarWidget({this.title}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  List<Product> shoppingCartProducts = [];
  @override
  Widget build(BuildContext context) {
    shoppingCartProducts = Provider.of<UserCartProductsProvider>(context).cartProductsList;
    return Container(
      height: kToolbarHeight,
      child: AppBar(
          title: Text(widget.title?? ""),
          backgroundColor: Main_Purple,
          actions: [
            IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.shopping_cart, color: White,),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          shoppingCartProducts.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed(SHOPPING_CART);
                }),
            SizedBox(width: 10)
          ],
        ),
    );
  }
}