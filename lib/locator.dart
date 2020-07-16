import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/blog/blog_service.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/authentication/FirebaseAuthentication.dart';
import 'package:ecommerceApp/Services/category_services.dart';
import 'package:ecommerceApp/Services/dialog_service.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/Services/shipping/shipping_service.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerceApp/Services/geo_services.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Api>(() => WooCommerceDataSource());
  locator.registerLazySingleton<AuthApi>(() => AuthApi());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ShippingService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => CategoryServices());
  locator.registerLazySingleton(() => SettingsServices());
  locator.registerLazySingleton(() => GeoServices());
  locator.registerLazySingleton(() => BlogService());
  locator.registerFactory(() => FirebaseAuthenticationServices());
}
