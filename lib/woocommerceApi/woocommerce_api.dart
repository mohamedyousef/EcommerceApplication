import 'dart:async';
import "dart:collection";
import 'dart:convert';
import 'dart:io';
import "dart:math";
import "dart:core";
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ecommerceApp/woocommerceApi/cach_manager.dart';
import 'package:ecommerceApp/woocommerceApi/query_string.dart';
import 'package:ecommerceApp/woocommerceApi/woocommerce_error.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// [url] is you're site's base URL, e.g. `https://www.yourdomain.com`
///
/// [consumerKey] is the consumer key provided by WooCommerce, e.g. `ck_1a2b3c4d5e6f7g8h9i`
///
/// [consumerSecret] is the consumer secret provided by WooCommerce, e.g. `cs_1a2b3c4d5e6f7g8h9i`
///
/// [isHttps] check if [url] is https based
class WooCommerceAPI {
  String url;
  String consumerKey;
  String consumerSecret;
  bool isHttps;
  Dio dio;



  WooCommerceAPI({
    @required String url,
    @required String consumerKey,
    @required String consumerSecret,
  }) {
    this.url = url;
    this.consumerKey = consumerKey;
    this.consumerSecret = consumerSecret;
    BaseOptions options = new BaseOptions(
      baseUrl: url,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: url,maxMemoryCacheCount: 1000,
        defaultMaxStale: Duration(days: 15)
        ,defaultMaxAge: Duration(
      days: 10,
    ))).interceptor);

    if (this.url.startsWith("https")) {
      this.isHttps = true;
    } else {
      this.isHttps = false;
    }
  }

  /// Generate a valid OAuth 1.0 URL
  ///
  /// if [isHttps] is true we just return the URL with
  /// [consumerKey] and [consumerSecret] as query parameters
  String _getOAuthURL(String requestMethod, String endpoint) {
    String consumerKey = this.consumerKey;
    String consumerSecret = this.consumerSecret;

    String token = "";
    String url = this.url + "/wp-json/wc/v3/" + endpoint;
    bool containsQueryParams = url.contains("?");

    if (this.isHttps == true) {
      return url +
          (containsQueryParams == true
              ? "&consumer_key=" +
                  this.consumerKey +
                  "&consumer_secret=" +
                  this.consumerSecret
              : "?consumer_key=" +
                  this.consumerKey +
                  "&consumer_secret=" +
                  this.consumerSecret);
    }

    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    /// The timestamp allows the Service Provider to only keep nonce values for a limited time
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    String parameters = "oauth_consumer_key=" +
        consumerKey +
        "&oauth_nonce=" +
        nonce +
        "&oauth_signature_method=HMAC-SHA1&oauth_timestamp=" +
        timestamp.toString() +
        "&oauth_token=" +
        token +
        "&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = new SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = parameterString +
          Uri.encodeQueryComponent(key) +
          "=" +
          treeMap[key] +
          "&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    String method = requestMethod;
    String baseString = method +
        "&" +
        Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url) +
        "&" +
        Uri.encodeQueryComponent(parameterString);

    String signingKey = consumerSecret + "&" + token;
    crypto.Hmac hmacSha1 =
        crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1

    /// The Signature is used by the server to verify the
    /// authenticity of the request and prevent unauthorized access.
    /// Here we use HMAC-SHA1 method.
    crypto.Digest signature = hmacSha1.convert(utf8.encode(baseString));

    String finalSignature = base64Encode(signature.bytes);

    String requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = url.split("?")[0] +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    } else {
      requestUrl = url +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    }

    return requestUrl;
  }

  /// Handle network errors if [response.statusCode] is not 200 (OK).
  ///
  /// WooCommerce supports and give informations about errors 400, 401, 404 and 500
  Exception _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
      case 401:
      case 404:
      case 500:
        throw Exception(
            WooCommerceError.fromJson(json.decode(response.body)).toString());
      default:
        throw Exception(
            "An error occurred, status code: ${response.statusCode}");
    }
  }

  Future<dynamic> getAsync(String endPoint,{bool forceUpdate= false}) async {
    String url = this._getOAuthURL("GET", endPoint);

    try {
//      final http.Response response = await http.get(url);
//      if (response.statusCode == 200) {
//        return json.decode(response.body);
//      }
      return getData(url,forceUpdate: forceUpdate);
     // _handleError(response);
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  }

  Future<dynamic> getTestData(String endPoint) async {
    String url = this._getOAuthURL("GET", endPoint);

    try {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }

      _handleError(response);
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  }
  Future<dynamic> getData(String url, {Map<String, String> headers,bool forceUpdate=false}) async {
//    var file = await MyCacheManager().getSingleFile(url, headers: headers);
//    if (file != null && await file.exists()) {
//      var res = await file.readAsString();
//      return json.decode(res);
//    }
    Response response = await dio.get(url,options: buildCacheOptions(
      Duration(days: 12),
      options: Options(headers: headers),
      forceRefresh: forceUpdate,
      maxStale: Duration(days: 14),
    ),

    );
    return response.data;
    return null;
  }

  Future<dynamic> postAsync(String endPoint, Map data) async {
    String url = this._getOAuthURL("POST", endPoint);

    // http.Client client = dio.Client();
    final response = await dio.postUri(
        Uri.parse(url), data: data, options: Options(
      contentType: Headers.jsonContentType,

    ));

//    request.headers[HttpHeaders.contentTypeHeader] =
//        'application/json; charset=utf-8';
//    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
//    request.body = json.encode(data);
//    String response =
//        await client.send(request).then((res) => res.stream.bytesToString());
//    var dataResponse = await json.decode(response);

    return response.data;
  }
  Future<dynamic> deleteAsync(String endPoint) async {
    String url = this._getOAuthURL("Delete", endPoint);
    final response = await dio.deleteUri(
        Uri.parse(url),options: Options(
      contentType: Headers.jsonContentType,
    ));
//    http.Client client = http.Client();
//    http.Request request = http.Request('Delete', Uri.parse(url));
//    request.headers[HttpHeaders.contentTypeHeader] =
//    'application/json; charset=utf-8';
//    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
   // request.body = json.encode(data);
//    String response =
//    await client.send(request).then((res) => res.stream.bytesToString());
//    var dataResponse = await json.decode(response);

    return response;
  }

  Future<dynamic> updateAsync(String endPoint, Map data) async {
    String url = this._getOAuthURL("PUT", endPoint);

    // http.Client client = dio.Client();
    final response = await dio.putUri(
        Uri.parse(url), data: data, options: Options(
      contentType: Headers.jsonContentType,
    ));
//    http.Client client = http.Client();
//    http.Request request = http.Request('PUT', Uri.parse(url));
//    request.headers[HttpHeaders.contentTypeHeader] =
//    'application/json; charset=utf-8';
//    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
//    request.body = json.encode(data);
//    String response =
//    await client.send(request).then((res) => res.stream.bytesToString());
//    var dataResponse = await json.decode(response);

    return response;
  }
}
