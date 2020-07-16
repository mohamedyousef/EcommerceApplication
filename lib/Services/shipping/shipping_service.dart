import 'package:ecommerceApp/Models/shipping/shipping_method.dart';
import 'package:ecommerceApp/Models/shipping/shipping_zone.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import '../wocommerce_datasource_api.dart';
import '../wocommerce_datasource_api.dart';
import '../wocommerce_datasource_api.dart';

class ShippingService {
  List<ShippingZone> shippingZone;
  // list<ShippongZoneLocation> ;

  Api api = locator<Api>();
  Future<List<ShippingZoneMethod>> getShippingMethod(int zoneId) async {
    List<ShippingZoneMethod> shippingZoneMethods = List();
    shippingZoneMethods = await api.getShippingZoneMethods(zoneId);
    return shippingZoneMethods;
  }

  Future<void> getShippingZone() async {
    if (shippingZone == null)
      shippingZone = await api.getAllShippingZone();
  }
}
