import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:ecommerceApp/Models/ShippingLine.dart';
import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Models/shipping/shipping_method.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/Services/shipping/shipping_service.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerceApp/Models/coupone.dart';

class CheckOutProvider extends ChangeNotifier {
  NavigationService navigationService = locator<NavigationService>();
  SettingsServices settingsServices = locator<SettingsServices>();
  AuthenticationService authenticationService = locator<AuthenticationService>();
  ShippingService shippingService = locator<ShippingService>();
  Api api = locator<Api>();
  ShoppingCartProvider shoppingCartProvider;
  List<ShippingZoneMethod> _shippingMethods;
  int _currentShippingMethod = 0;
  int _currentPaymentMethods = 0;
  StreamController<bool> streamController = BehaviorSubject<bool>();
  String _resultLoadingcoupons;

  String get resultLoadingcoupons => _resultLoadingcoupons;
  bool _couponFinished;

  bool get couponFinished => _couponFinished;

  set couponFinished(bool value) {
    _couponFinished = value;
    notifyListeners();
  }

  set resultLoadingcoupons(String value) {
    _resultLoadingcoupons = value;
    notifyListeners();
  }

  int get currentPaymentMethods => _currentPaymentMethods;
  List<Coupon> _coupon = List<Coupon>();

  set coupon(List<Coupon> value) {
    _coupon = value;
    notifyListeners();
  }

  List<Coupon> get coupon => _coupon;

  set currentPaymentMethods(int value) {
    _currentPaymentMethods = value;
    notifyListeners();
  }

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  int get currentSelected => _currentShippingMethod;

  set currentSelected(int value) {
    _currentShippingMethod = value;
    notifyListeners();
  } // List<ShippingZone>shippingZone;
  // list<ShippongZoneLocation> ;

  Ing _shippingAddress;

  CheckOutProvider(this.shoppingCartProvider);

  Ing get shippingAddress => _shippingAddress;

  set shippingAddress(Ing value) {
    _shippingAddress = value;
    notifyListeners();
  }

  set shippingMethods(List<ShippingZoneMethod> value) {
    _shippingMethods = value;
    print(value[0].settings.cost.value);

    notifyListeners();
  }

  List<ShippingZoneMethod> get shippingMethods => _shippingMethods;

  void proceedPayment({bool setPaid = false}) async {
    setBusy = true;
    final response = await api.requestOrder(Order(
        paymentMethod: (setPaid == false) ? "cod" : "",
        setPaid: setPaid,
        shipping: shippingAddress,
        billing: shippingAddress,
        productCarts: shoppingCartProvider.products,
        couponLines: _coupon,
        shippingLines: [
          ShippingLine(
              methodId: shippingMethods[_currentShippingMethod].methodId,
              methodTitle: shippingMethods[_currentShippingMethod].methodTitle,
              total:
                  shippingMethods[_currentShippingMethod].settings.cost != null
                      ? shippingMethods[_currentShippingMethod]
                          .settings
                          .cost
                          .value
                          .toString()
                      : 0.toString())
        ]));
    if (response != null) {
      setBusy = false;
      print(response.toString());
      navigationService.navigateTo(CongratsRoute);
    }
  }

  void getShippingMethods() async {
    if (shippingAddress != null) {
      int zoneId = shippingService.shippingZone
          .singleWhere((element) => element.name == _shippingAddress.country)
          .id;

      if (zoneId != null)
        _shippingMethods = await shippingService.getShippingMethod(zoneId);
      else
        _shippingMethods = await shippingService.getShippingMethod(0);

      notifyListeners();
    }
  }

  void removeCoupon(Coupon coupon){
    _coupon.remove(coupon);
    notifyListeners();
  }

  double getDiscountTotal(){
    double subTotal = shoppingCartProvider.getTotalPrice();
    double discountAmount = 0;
      for (var item in coupon) {
        double total =  0;
        if (item.discountType == CouponeDiscountType.percent) {
          double sum = double.parse(item.amount) * 0.01;
          total = sum * subTotal;
        }
        else
          total += double.parse(item.amount);
       // if(double.parse(item.maximumAmount)>=total&&total>=double.parse(item.minimumAmount))
          discountAmount += total;
      }

    return discountAmount;
  }
  double getTotalPrice() {
    double subTotal = shoppingCartProvider.getTotalPrice();
    double discountAmount = 0;
    if (coupon.isNotEmpty)
      for (var item in coupon) {
        double total =  0;
        if (item.discountType == CouponeDiscountType.percent) {
          double sum = double.parse(item.amount) * 0.01;
          total = sum * subTotal;
        } else
          total += double.parse(item.amount);
      //  if(double.parse(item.maximumAmount)>=total&&total>=double.parse(item.minimumAmount))
          discountAmount += total;
      }

//    if(discountAmount!=null)
//      discountAmount = api.get ;
    try {
      double shipping = (shippingMethods != null)
          ?
          // ( checkOutProvider.shippingMethods[checkOutProvider.currentSelected].settings.cost != null) ?

          double.parse(shippingMethods[currentSelected].settings.cost.value)
          : 0;

      return (subTotal + shipping) - discountAmount;
    } catch (e) {
      return subTotal-discountAmount;
    }
  }

  void searchCoupon(String code) async {
    streamController.add(true);

    List<Coupon> data = await api.getCoupons(code);

    if (data.isNotEmpty) {
      if (data[0].usageCount >= data[0].usageLimit)
        _resultLoadingcoupons = "This Coupon Has Been Used";
      else {
        coupon.add(data[0]);
        _couponFinished = true;
      }
    }
    else {
      _resultLoadingcoupons = "Coupon Not Found";
    }
    streamController.add(false);
    notifyListeners();
  }
}
