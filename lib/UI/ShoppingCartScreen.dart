import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:flutter_test_project/Utilities/Provider/UserProductsProvider.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/AppBarWidget.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/AppDrawer.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Product> productsList = [];
  List<Product> userProductsWithCount = [];
  bool isProductsListInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!isProductsListInitialized) {
      productsList =
          Provider.of<UserCartProductsProvider>(context).cartProductsList;
      productsList.forEach((product) {
        if (product.noOfItems == null) product.noOfItems = 1;
      });
      userProductsWithCount = getEachProductWithCount();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(title: "Shopping Cart"),
        drawer: AppDrawerWidget(),
        body: Column(
          children: [
            Expanded(child: getProductsCardsWidget()),
            getShoppingCartFooterWidget(context),
          ],
        ),
      ),
    );
  }

  Column getShoppingCartFooterWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppUtils.getScreenWidth(context) * 0.98,
          height: 50,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                ),
                side: BorderSide(color: Colors.white),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("Order Total:"),
                    Spacer(),
                    Text(getTotalPrice() + " SAR"),
                    IconButton(
                        icon: Icon(Icons.delete, color: RED),
                        onPressed: clearShoppingCart)
                  ],
                ),
              )),
        ),
        Container(
          width: AppUtils.getScreenWidth(context) * 0.98,
          child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ALL_PRODUCTS);
              },
              color: Main_Purple,
              child: Text(
                "Continue Shopping",
                style: basicWhiteTextStyle,
              )),
        ),
        Container(
          width: AppUtils.getScreenWidth(context) * 0.98,
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ALL_PRODUCTS);
            },
            color: Main_Fuscia,
            child: Text(
              "Checkout",
              style: basicWhiteTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget getProductsCardsWidget() {
    return ListView.builder(
      itemCount: userProductsWithCount.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: AppUtils.getScreenHeight(context) * 0.2,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.white),
              ),
              child: getProductCardContent(index, context)),
        );
      },
    );
  }

  Row getProductCardContent(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          ),
          child: Image.network(userProductsWithCount[index].photo,
              width: AppUtils.getScreenWidth(context) * 0.3,
              height: AppUtils.getScreenHeight(context),
              fit: BoxFit.cover),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: Text(
            userProductsWithCount[index].productName,
            style: titleTextStyle,
            textAlign: TextAlign.left,
          ),
        ),
        Spacer(),
        Expanded(
          flex: 9,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Price: " + userProductsWithCount[index].price + " SAR",
                  style: greyTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Sub Total: ${int.parse(userProductsWithCount[index].price) * userProductsWithCount[index].noOfItems} SAR",
                  style: greyTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
        ),
        getProductCountWidget(userProductsWithCount[index]),
        SizedBox(width: 5),
      ],
    );
  }

  Column getProductCountWidget(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Main_Purple,
            ),
            onPressed: () => handleProductAddAction(product)),
        Text(
          product.noOfItems.toString(),
          style: titleTextStyle,
        ),
        IconButton(
            icon: Icon(
              Icons.remove_circle,
              color:
                  productsListContainsProduct(userProductsWithCount, product.id)
                      ? Main_Purple
                      : Main_Purple.withOpacity(0.5),
            ),
            onPressed:
                productsListContainsProduct(userProductsWithCount, product.id)
                    ? () => handleProductRemoveAction(product)
                    : null),
      ],
    );
  }

  productsListContainsProduct(List<Product> products, int productID) {
    bool productIncluded = false;
    products.forEach((product) {
      if (product.id == productID) productIncluded = true;
    });
    return productIncluded;
  }

  handleProductRemoveAction(Product product) {
    int index = productsList.indexWhere((element) => element.id == product.id);
    setState(() {
      productsList.removeAt(index);
      if (userProductsWithCount
              .firstWhere((userProduct) => userProduct.id == product.id)
              .noOfItems >
          0) {
        userProductsWithCount
            .firstWhere((userProduct) => userProduct.id == product.id)
            .noOfItems--;
      }
    });
  }

  handleProductAddAction(Product product) {
    setState(() {
      productsList.add(product);
      userProductsWithCount
          .firstWhere((userProduct) => userProduct.id == product.id)
          .noOfItems++;
    });
  }

  clearShoppingCart() {
    setState(() {
      productsList = [];
      userProductsWithCount = [];
      Provider.of<UserCartProductsProvider>(context, listen: false).cartProductsList = [];
    });
  }

  String getTotalPrice() {
    int totalPrice = 0;
    productsList.forEach((product) {
      totalPrice += int.parse(product.price);
    });
    return totalPrice.toString();
  }

  List<Product> getEachProductWithCount() {
    List<Product> products = [];
    productsList.forEach((product) {
      if (!productsListContainsProduct(products, product.id)) {
        products.add(product);
      } else
        products
            .firstWhere((newProduct) => product.id == newProduct.id)
            .noOfItems++;
    });
    setState(() {
      isProductsListInitialized = true;
    });
    return products;
  }
}
