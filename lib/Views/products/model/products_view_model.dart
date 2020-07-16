import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class ProductsModel extends BaseViewModel {

  Api  api= locator<Api>();

  List<Product>_products=List();
  String _filter="";
  int _categoryID;


  int get categoryID => _categoryID;

  set categoryID(int value) {
    _categoryID = value;
    notifyListeners();
  } //  String get filter => _filter;
//
//  set filter(String value) {
//    _filter = value;
//    notifyListeners();
//  }

  NavigationService navigationService  = locator<NavigationService>();
  List<Product> get products => _products;
  int per_page = 25;
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

  Future<void> requestLoadMore({String filter,bool ratings,bool total_sales})async{


    if(!_hasMorePosts) return;

    List<Product>newPosts = await api.getProducts(limit: per_page,page: page,filter: filter);
//    if(ratings)
//    newPosts.sort(
//        (a,b)=>double.parse(a.averageRating).compareTo(double.parse(b.averageRating))
//    );
//
//    if(total_sales)
//      newPosts.sort(
//              (a,b)=>a.totalSales.compareTo(b.totalSales)
//      );

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

  Future<void> applyFilter(
      {String filter})async{

    per_page= 25;
    page= 1;

    if (waitForNextRequest) {
      return;
    }
    waitForNextRequest = true;

    _products.clear();
    List<Product>newPosts = await api.getProducts(limit: per_page,page: page,filter: filter);
    if(newPosts.length==0)
      _hasMorePosts = false;
    page = page+1;
    _products.addAll(newPosts);
    print(newPosts.toString());
  waitForNextRequest = false;
    notifyListeners();
  }


//  int _index_catIndex;
//
//  int get index_catIndex => _index_catIndex;
//
//  set index_catIndex(int value) {
//    _index_catIndex = value;
//    notifyListeners();
//  }


//  void listenToProducts(String filter) {
//   setBusy(true);
//    _productServices.listenToPostsRealTime(filter).listen((postsData) {
//      List<Product> updatedPosts = postsData;
//      if (updatedPosts != null && updatedPosts.length > 0) {
//        _products = updatedPosts;
//        notifyListeners();
//      }
//   setBusy(false);
//    });
//  }
//  void requestMoreData({String filter}) => _productServices.requestLoadMore(filter: filter);

}