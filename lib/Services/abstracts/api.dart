import 'package:ecommerceApp/Models/AttrributeName.dart';
import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/settings.dart';
import 'package:ecommerceApp/Models/shipping/shipping_location.dart';
import 'package:ecommerceApp/Models/shipping/shipping_method.dart';
import 'package:ecommerceApp/Models/shipping/shipping_zone.dart';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:ecommerceApp/Models/coupone.dart';
import 'package:ecommerceApp/Models/order.dart';

abstract class Api {
  Future<Product> getProduct(int id);
  Future<List<Product>> getProducts(
      {int limit = 20, int page = 1, String filter});
  Future<List<Product>> search(String search,
      {int limit = 15, int page = 1,String filter});
  Future<List<Category>> getCategories();
  Future<dynamic> requestOrder(Order order);
  Future<Variation> getVariation(int productID, int id);
  Future<List<Variation>> getVariations(int productID);
  Future<List<AttributeName>> getAllAttrubutes();
  Future<List<AttributeTerm>> getAttribute(int id);
  Future<List<ShippingZone>> getAllShippingZone();
  Future<List<Review>> getReviews(int productID,{String filter});
  Future<dynamic>writeReview(Review review);
  Future<List<ShippingLocation>> getShippingZoneLocations(int zoneId);
  Future<List<ShippingZoneMethod>> getShippingZoneMethods(int zoneId);
  Future<Map<String, dynamic>> saveCustomer(User user);
  Future<Settings> getSettings();
  Future<List<wp.Post>> getAllPosts({int limit= 25,int page=1});
  Future<List<Coupon>>getCoupons(String code);
  Future<List<Order>>getAllOrders();
  Future<ProductCart>getProductCartFromOrder(int productId,int qty, {int varId});
  Future<dynamic> deleteReview(int id);
  Future<dynamic> updateReview(Review review);


}