import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

Map<String, dynamic> fromJson(String source) => json.decode(source);

Future<double> convertCurrency(
    {String fromCurrency = "USD",
      @required String toCurrency}) async {
  String uri =
      "https://free.currconv.com/api/v7/convert?q=${fromCurrency}_${toCurrency}&compact=ultra&apiKey=35f9283e5d89d1397e93";

  var response = await http
      .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
  var responseBody = json.decode(response.body);
 // String result = responseBody["rates"][toCurrency];

  return responseBody["${fromCurrency}_${toCurrency}"];
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
  );

  return htmlText.replaceAll(exp, '');
}



