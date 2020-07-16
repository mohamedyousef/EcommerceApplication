import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class BlogService {
  Api api = locator<Api>();
  List<Post> posts = List();

  Future<List<Post>> getPosts() async {
    if (posts.isEmpty) posts = await api.getAllPosts(limit: 3, page: 1);
    return posts;
  }
}
