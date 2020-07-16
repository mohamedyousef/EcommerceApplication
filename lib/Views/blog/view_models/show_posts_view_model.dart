import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:stacked/stacked.dart';

class PostsViewModel extends BaseViewModel{

  NavigationService navigationService  = locator<NavigationService>();
  Api api =  locator<Api>();
  List<Post> posts = List();
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

 Future<void> fetchMorePosts() async {
    if(hasMorePosts==false)
      return;

    if (waitForNextRequest) {
      return;
    }

    waitForNextRequest = true;
    await  requestMorePosts();
    waitForNextRequest = false;
  }

  requestMorePosts() async{
    if(!_hasMorePosts) return;
    List<Post>newPosts = await api.getAllPosts(limit: per_page,page: page);
    if(newPosts.length<25)
      _hasMorePosts = false;
    page = page+1;
    posts.addAll(newPosts);
    notifyListeners();
  }



}