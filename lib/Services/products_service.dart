import 'dart:async';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/locator.dart';

import 'abstracts/api.dart';

class ProductServices {

  Api _api =  locator<Api>();

  static const int per_page = 20;
  int page =  1 ;
  bool _hasMorePosts = true;

  List<Product> _allPagedResults = List<Product>();
//  final StreamController<List<Product>> _postsController = StreamController<List<Product>>.broadcast();
  String filter;

//  Stream listenToPostsRealTime(String filter) {
//    // Register the handler for when the posts data changes
//    requestLoadMore(filter: filter);
//    return _postsController.stream;
//  }

  Future<void> requestLoadMore({String filter})async{

     if(this.filter!=filter) {
       _allPagedResults.clear();
       this.filter = filter;
       page = 1;
       _hasMorePosts = true;
     }

     List<Product>newPosts = await _api.getProducts(page: page,filter: filter);
    _allPagedResults.addAll(newPosts);
     if(!_hasMorePosts) return;

//    var allPosts = _allPagedResults.fold<List<Post>>(List<Post>(),
//            (initialValue, pageItems) => initialValue..addAll(pageItems));


    // #12: Broadcase all posts
     // _postsController.add(_allPagedResults);


    if(newPosts.length<20)
      _hasMorePosts = false;

    page ++;

  }



}