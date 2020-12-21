import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
          title: Text(widget.product.productName?? ""),
          backgroundColor: Main_Purple,
          automaticallyImplyLeading: true,
        ),
      body: Center(
        child: Container(
          width: AppUtils.getScreenWidth(context) * 0.8,
          height: AppUtils.getScreenHeight(context) * 0.6,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.white),
              ),
              child: getProductCardContent()),
        ),
      ),
    ));
  }

  Column getProductCardContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: Image.network(widget.product.photo,
              width: AppUtils.getScreenWidth(context),
              height: AppUtils.getScreenHeight(context) * 0.4,
              fit: BoxFit.fill),
        ),
        Text(
          widget.product.productName,
          style: titleTextStyle,
        ),
        Text(
          widget.product.price + " SAR",
          style: greyTextStyle,
        ),
        SizedBox(
          height: 10
        )
      ],
    );
  }
}
