import 'package:flutter/material.dart';
import 'package:flutter_test_project/Model/AllProducts.dart';
import 'package:flutter_test_project/Presenter/AllProductsPresenter.dart';
import 'package:flutter_test_project/UI/ProductDetailsScreen.dart';
import 'package:flutter_test_project/Utilities/AppConstants.dart';
import 'package:flutter_test_project/Utilities/AppUtils.dart';
import 'package:flutter_test_project/Utilities/Provider/UserProductsProvider.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/AppBarWidget.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/AppDrawer.dart';
import 'package:flutter_test_project/Utilities/WidgetUtils/TextFieldWidget.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen>
    implements AllProductsContract {
  String userName;
  String mobile;
  int pageNumber;
  int pagesCount = 1;
  bool isFirstPageLoaded = false;
  List<Product> productsList = [];
  List<Product> shoppingCartProducts = [];
  List<Product> filteredProductsList = [];
  List<Product> userProductsWithCount = [];
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
    shoppingCartProducts =
        Provider.of<UserCartProductsProvider>(context).cartProductsList;
    userProductsWithCount = Provider.of<UserCartProductsProvider>(context).cartProductsListWithCount;
    print(
        "No. Of Products ==== ${Provider.of<UserCartProductsProvider>(context).cartProductsList.length}");
    if (!isFirstPageLoaded) loadFirstPage();
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(title: "All Products",),
        drawer: AppDrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextFieldWidget(
                hintText: "Search Products",
                onValueChanged: (value){
                  if(AppUtils.isNotEmptyText(value)){
                    filteredProductsList = productsList.where((product) => product.productName.trim().startsWith(value.trim())).toList();
                    setState(() {
                      filteredProductsList = filteredProductsList.length > 10? filteredProductsList.getRange(0, 9) : filteredProductsList;
                    });
                  } else filteredProductsList = productsList;
                },
              ),
            ),
            isFirstPageLoaded
                ? Expanded(
                    child: getProductsCardsWidget(),
                  )
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  GridView getProductsCardsWidget() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.5),
      controller: _scrollController,
      itemCount: filteredProductsList.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: AppUtils.getScreenHeight(context) * 0.8,
          child: GestureDetector(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.white),
                ),
                child: getProductCardContent(index, context)),
            onTap: (){
              Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: filteredProductsList[index],)));
            },
          ),
        );
      },
    );
  }

  Column getProductCardContent(int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: Image.network(filteredProductsList[index].photo,
              width: AppUtils.getScreenWidth(context),
              height: AppUtils.getScreenHeight(context) * 0.37,
              fit: BoxFit.cover),
        ),
        Text(
          filteredProductsList[index].productName,
          style: titleTextStyle,
        ),
        Text(
          filteredProductsList[index].price + " SAR",
          style: greyTextStyle,
        ),
        getProductCountWidget(filteredProductsList[index]),
      ],
    );
  }

  Row getProductCountWidget(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: productsListContainsProduct(product.id)
                  ? Main_Purple
                  : Main_Purple.withOpacity(0.5),
            ),
            onPressed: productsListContainsProduct(product.id)
                ? () => handleProductRemoveAction(product)
                : null),
        Text(
          getSpecificProductCount(product.id).toString(),
          style: titleTextStyle,
        ),
        IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Main_Purple,
            ),
            onPressed: () => handleProductAddAction(product)),
        SizedBox(height: 10),
      ],
    );
  }

  getSpecificProductCount(int productID) {
    return shoppingCartProducts
        .where((product) => product.id == productID)
        .length;
  }

  productsListContainsProduct(int productID) {
    bool productIncluded = false;
    shoppingCartProducts.forEach((product) {
      if (product.id == productID) productIncluded = true;
    });
    return productIncluded;
  }

  handleProductRemoveAction(Product product) {
    userProductsWithCount.firstWhere((element) => element.id == product.id).noOfItems--;
    int index =
        shoppingCartProducts.indexWhere((element) => element.id == product.id);
    setState(() {
      shoppingCartProducts.removeAt(index);
    });
  }

  handleProductAddAction(Product product) {
    if(productsListContainsProduct(product.id)) userProductsWithCount.firstWhere((element) => element.id == product.id).noOfItems++;
    else {
      product.noOfItems = 1;
      userProductsWithCount.add(product);
    }
    setState(() {
      shoppingCartProducts.add(product);
    });
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
      filteredProductsList = productsList;
    });
  }
}
