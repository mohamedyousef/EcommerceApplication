import 'dart:convert';
import 'package:ecommerceApp/Models/payment/card_model.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../AuthenticationServices.dart';
import 'card_service.dart';
import 'package:ecommerceApp/Models/payment/card_model.dart';


class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = 'your_api_secret';
  static const CUSTOMERS_URL = "https://api.stripe.com/v1/customers";

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
            publishableKey: "your_api_publishable_key",
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
  }

 static Future<String> createStripeCustomer({String email, String userId})async{
    Map<String, String> body = {
      'email': email,
    };

    String stripeId = await http.post(CUSTOMERS_URL, body: body, headers: headers)
        .then((response){
      String stripeId = jsonDecode(response.body)["id"];
      print("The stripe id is: $stripeId");
      AuthenticationService userService = AuthenticationService();
      userService.updateDetails({
        "id": userId,
        "stripeId": stripeId
      });
      return stripeId;
    }).catchError((err){
      print("==== THERE WAS AN ERROR ====: ${err.toString()}");
      return null;
    });

    return stripeId;
  }

  static Future<StripeTransactionResponse> payViaExistingCard({String amount, String currency, String paymentMethod}) async{
    try {
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod
          )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }


// static Future<void> addCard({int cardNumber, int month, int year, int cvc, String stripeId, String userId})async{
//   Map body = {
//     "type": "card",
//     "card[number]": cardNumber,
//     "card[exp_month]": month,
//     "card[exp_year]":year,
//     "card[cvc]":cvc
//   };
//   Dio().post(PAYMENT_METHOD_URL, data: body, options: Options(contentType: Headers.formUrlEncodedContentType, headers: headers)).then((response){
//     String paymentMethod = response.data["id"];
//     print("=== The payment mathod id id ===: $paymentMethod");
//     http.post("https://api.stripe.com/v1/payment_methods/$paymentMethod/attach",
//         body: {
//           "customer": stripeId
//         },
//         headers: headers
//     ).catchError((err){
//       print("ERROR ATTACHING CARD TO CUSTOMER");
//       print("ERROR: ${err.toString()}");
//
//     });
//
//   });
// }

  static void addCard(CreditCard card)async{
    AuthenticationService userService = locator<AuthenticationService>();
    var paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card, )
    );

    CardServices cardServices = CardServices();
    cardServices.createCard(CardModel(
        id: paymentMethod.id,
        last4: int.parse(card.last4.toString().substring(11)),
        month: card.expMonth, year: card.expYear,
        userId: userService.userData.uid,brand:card.brand));

    userService.updateDetails({
      "id": userService.userData.uid,
      "activeCard": paymentMethod.id
    });

  }

  static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest()
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true
        );
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}',
          success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message,
        success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          StripeService.paymentApiUrl,
          body: body,
          headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}
