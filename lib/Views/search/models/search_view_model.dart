import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel{

  NavigationService navigationService = locator<NavigationService>();
  Api api = locator<Api>();
  List<Product> _products= List();
  List<Product> get products => _products;
  Product _firstProduct ;
  Product get firstProduct => _firstProduct;
  bool  _searchFinished =false;
//  String _searchPattern;

//
//  String get searchPattern => _searchPattern;
//
//  set searchPattern(String value) {
//    _searchPattern = value;
//    notifyListeners();
//  }

  bool get searchFinished => _searchFinished;

  set searchFinished(bool value) {
    _searchFinished = value;
    notifyListeners();
  }

  set firstProduct(Product value) {
    _firstProduct = value;
    notifyListeners();
  }

  void searchProductByName(String productName)async{
    _products  = await api.search(productName.trim(),limit: per_page);
    if(_products!=null&&_products.isNotEmpty) {
      _firstProduct = _products[0];
    }
    _hasMorePosts = true;
    page=2;
    notifyListeners();
  }

  int per_page =11;
  int page =  1 ;
  bool _hasMorePosts = true;

  set hasMorePosts(bool value) {
    _hasMorePosts = value;
  }

  bool get hasMorePosts => _hasMorePosts;
  bool _waitForNextRequest=false;


  bool get waitForNextRequest => _waitForNextRequest;

  set waitForNextRequest(bool value) {
    _waitForNextRequest = value;
    notifyListeners();
  } //  final StreamController<List<Product>> _postsController = StreamController<List<Product>>.broadcast();


  Future<void> fetchMore(String _searchPattern)async{
    if(!_hasMorePosts) return;
    List<Product>newPosts = await api.search(_searchPattern,limit: per_page,page: page);
    if(newPosts.length==0)
      _hasMorePosts = false;
    page = page+1;
    _products.addAll(newPosts);

//    var allPosts = _allPagedResults.fold<List<Post>>(List<Post>(),
//            (initialValue, pageItems) => initialValue..addAll(pageItems));


    // #12: Broadcase all posts
    // _postsController.add(_allPagedResults);

    notifyListeners();
  }







}