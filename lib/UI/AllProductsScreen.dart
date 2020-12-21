import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Presenter/AllProductsPresenter.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/AppDrawer.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/TextFieldWidget.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen>
    implements AllProductsContract {
  var localStorage;
  String userName;
  String mobile;
  int pageNumber;
  int pagesCount = 1;
  bool isFirstPageLoaded = false;
  List<Product> productsList = [];
  ScrollController _scrollController = ScrollController();
  AllProductsPresenter _allProductsPresenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageNumber = 1;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isFirstPageLoaded) loadFirstPage();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Products"),
          backgroundColor: Main_Purple,
          actions: [Icon(Icons.shopping_cart), SizedBox(width: 10)],
        ),
        drawer: AppDrawerWidget(),
        body: Column(
          children: [
            TextFieldWidget(
              hintText: "Search Items",
            ),
            isFirstPageLoaded
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      controller: _scrollController,
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: AppUtils.getScreenHeight(context) * 0.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.white),
                            ),
                            child: ListTile(
                                title: Image.network(
                                  productsList[index].photo,
                                  fit: BoxFit.cover,
                                  height: AppUtils.getScreenHeight(context),
                                  width:
                                      AppUtils.getScreenHeight(context) * 0.15,
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Text(productsList[index].productName),
                                    Text(
                                      productsList[index].price,
                                      style: geryTextStyle,
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  )
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  loadFirstPage() {
    AllProductsRequest allProductsRequest =
        AllProductsRequest(page: pageNumber.toString(), norecord: "4");
    _allProductsPresenter = AllProductsPresenter(this);
    _allProductsPresenter.getAllProductsList(allProductsRequest, context);
  }

  getMoreProducts() {
    pageNumber++;
    if (pageNumber <= pagesCount) {
      AllProductsRequest allProductsRequest =
          AllProductsRequest(page: pageNumber.toString(), norecord: "4");
      _allProductsPresenter = AllProductsPresenter(this);
      _allProductsPresenter.getAllProductsList(allProductsRequest, context);
    }
  }

  @override
  onGetProductsFailed(error) {
    // TODO: implement onGetProductsFailed
    throw UnimplementedError();
  }

  @override
  onGetProductsSuccess(AllProductsResponse allProductsList) {
    // TODO: implement onGetProductsSuccess
    productsList.addAll(allProductsList.data.products);
    pagesCount = allProductsList.lastPage;
    setState(() {
      isFirstPageLoaded = true;
    });
  }
}
