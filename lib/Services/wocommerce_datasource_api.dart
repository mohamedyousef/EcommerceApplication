import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceApp/Models/AttrributeName.dart';
import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Models/coupone.dart';
import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/settings.dart';
import 'package:ecommerceApp/Models/shipping/shipping_location.dart';
import 'package:ecommerceApp/Models/shipping/shipping_method.dart';
import 'package:ecommerceApp/Models/shipping/shipping_zone.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/config.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/woocommerceApi/woocommerce_api.dart';
import 'package:flutter_wordpress/schemas/post.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;

WooCommerceAPI _wooCommerceAPI = WooCommerceAPI(
    url: url, consumerKey: consumerKey, consumerSecret: consumerSecret);

wp.WordPress wordPress = wp.WordPress(
  baseUrl: url,
  authenticator: wp.WordPressAuthenticator.JWT,
  adminName: '',
  adminKey: '',
);


class WooCommerceDataSource implements Api {
  @override
  Future<Product> getProduct(int id) async {
    Map<String, dynamic> response =
        await _wooCommerceAPI.getAsync("products/${id}");
    return Product.fromJson(response);
  }

  @override
  Future<List<Product>> getProducts(
      {int limit = 20, int page = 1, String filter}) async {
    List<dynamic> response = await _wooCommerceAPI
        .getAsync("products?page=${page}&per_page=${limit}&${filter}",forceUpdate: true);

    return List.generate(
        response.length, (index) => Product.fromJson(response[index]));
  }

  @override
  Future<List<Product>> search(String search,
      {int limit = 15, int page = 1,String filter}) async {
    List<dynamic> response = await _wooCommerceAPI
        .getAsync("products?search=${search}&page=${page}&per_page=${limit}&${filter}",forceUpdate: true);
    return List.generate(
        response.length, (index) => Product.fromJson(response[index]));
  }

  @override
  Future<List<Category>> getCategories() async {
    List<dynamic> response =
        await _wooCommerceAPI.getAsync("products/categories?order=desc");
    return List.generate(
        response.length, (index) => Category.fromJson(response[index]));
  }

  @override
  Future<dynamic> requestOrder(Order order) async {
    return await _wooCommerceAPI.postAsync("orders", order.toJson());
  }

  @override
  Future<Settings> getSettings() async {
    Map<String, dynamic> data = await _wooCommerceAPI.getAsync("system_status");
    return Settings.fromJson(data["settings"]);
  }

  @override
  Future<Variation> getVariation(int productID, int id) async {
    Map<String, dynamic> response = await _wooCommerceAPI
        .getAsync("products/${productID}/variations/${id}?attributes=");

    return Variation.fromJson(response);
  }

  @override
  Future<List<Variation>> getVariations(int productID) async {
    List<dynamic> response =
        await _wooCommerceAPI.getAsync("products/${productID}/variations",forceUpdate: true);
    return List.generate(
        response.length, (index) => Variation.fromJson(response[index]));
  }

  @override
  Future<List<AttributeName>> getAllAttrubutes() async {
    List<dynamic> response =
        await _wooCommerceAPI.getAsync("products/attributes/");
    return List.generate(
        response.length, (index) => AttributeName.fromJson(response[index]));
  }

  @override
  Future<List<AttributeTerm>> getAttribute(int id) async {
    List<dynamic> response =
        await _wooCommerceAPI.getAsync("products/attributes/${id}/terms");
    return List.generate(
        response.length, (index) => AttributeTerm.fromJson(response[index]));
  }



  @override
  Future<List<ShippingZone>> getAllShippingZone() async {
    List<dynamic> response = await _wooCommerceAPI.getAsync("shipping/zones");
    return List.generate(
        response.length, (index) => ShippingZone.fromJson(response[index]));
  }

  @override
  Future<List<ShippingLocation>> getShippingZoneLocations(int zoneId) async {
    List<dynamic> response =
        await _wooCommerceAPI.getAsync("shipping/zones/${zoneId}/locations");
    return List.generate(
        response.length, (index) => ShippingLocation.fromJson(response[index]));
  }

  @override
  Future<List<ShippingZoneMethod>> getShippingZoneMethods(int zoneId) async {
    List<dynamic> response =
        await _wooCommerceAPI.getAsync("shipping/zones/${zoneId}/methods");
    return List.generate(
        response.length, (index) => ShippingZoneMethod.fromJson(response[index]));
  }

  @override
  Future<Map<String, dynamic>> saveCustomer(User user) async {
    return await _wooCommerceAPI.postAsync("customers", user.toJson());
  }

  @override
  Future<List<Post>> getAllPosts({int limit=25,int page=1}) {
   return wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: page,
        perPage: limit,
        order: wp.Order.desc,
        orderBy: wp.PostOrderBy.date,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
    );
  }

  @override
  Future<List<Coupon>> getCoupons(String code) async{
    List<dynamic>coupon =  await _wooCommerceAPI.getAsync("coupons?code=$code");
    return List.generate(
        coupon.length, (index) => Coupon.fromJson(coupon[index]));
  }

  @override
  Future<List<Order>> getAllOrders() async{
    List<dynamic> orders = await _wooCommerceAPI.getAsync("orders",forceUpdate: true);
    return List.generate(
        orders.length, (index) => Order.fromJson(orders[index]));
  }

  @override
  Future<ProductCart> getProductCartFromOrder(int productId,int quantity, {int varId=0})async {
    Product product = await getProduct(productId);
    Variation variation;
    if(varId>0)
     variation = await getVariation(productId, varId);
    return ProductCart(product,variation,quantity);
  }


  @override
  Future<List<Review>> getReviews(int productID,{String filter=""}) async {
    List<dynamic> response =
    await _wooCommerceAPI.getAsync("products/reviews?product=${productID}&${filter}",forceUpdate: true);
    return List.generate(
        response.length, (index) => Review.fromJson(response[index]));
  }

  @override
  Future writeReview(Review review)async{
      return await  _wooCommerceAPI.postAsync("products/reviews",review.toJson());
  }

  @override
  Future deleteReview(int id)async{
    return await _wooCommerceAPI.deleteAsync("products/reviews/$id");
  }

  @override
  Future updateReview(Review review) async {
    return await _wooCommerceAPI.updateAsync("products/reviews/${review.id}",review.toJson());
  }


}
class AuthApi {
  Firestore _firestore;
  CollectionReference _collectionReference;

  AuthApi() {
    this._firestore = Firestore.instance;
    this._collectionReference = _firestore.collection("Users");
  }

  Future<Map<String, dynamic>> saveCustomer(User user) async {
    return await _wooCommerceAPI.postAsync("customers", user.toJson());
  }

  Future<void> saveUser(User user) async {
    Map<String, dynamic> data = await saveCustomer(user);
    print(data.toString());
    DocumentReference documentReference =
        _collectionReference.document(user.uid);
    user.customerID = data["id"];
    user.uid = documentReference.documentID;
    return await documentReference.setData(user.toJson());
  }

  Future<void> updateShippingUser(String id, Ing shipping) async {
    DocumentReference documentReference =
        await _collectionReference.document(id);
    var batch = Firestore.instance.batch();
    batch.updateData(documentReference, {"shipping": shipping.toJson()});
    batch.commit();
  }

  Future<void> updateBillingUser(String id, Ing billing) async {
    await _collectionReference
        .document(id)
        .updateData({"billing": billing.toJson()});
  }

  Future<User> getUser(String userId,
      {String email,
      String photoUrl,
      String firstname,
      String last_Name}) async {
    DocumentSnapshot documentSnapshot =
        await _collectionReference.document(userId).get();
    if (documentSnapshot.exists)
      return User.fromJson(documentSnapshot.data,
          uid: documentSnapshot.documentID);
    else {
      User user = User(
          email: email,
          firstName: firstname,
          lastName: last_Name,
          avatarUrl: photoUrl,
          username: documentSnapshot.documentID);
      saveUser(user);
      return user;
    }
  }
}
