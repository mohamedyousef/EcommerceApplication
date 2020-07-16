import 'package:ecommerceApp/Models/settings.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/checkout_provider.dart';
import 'package:ecommerceApp/providers/countires_provider.dart';
import 'package:ecommerceApp/providers/filte_search_provider.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Services/NavigationServices.dart';
import 'package:ecommerceApp/router.dart' as router;
import 'constants/route_path.dart' as routes ;

void main() async{
  setupLocator();
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: ShoppingCartProvider(),),
    ChangeNotifierProvider.value(value: FilterSearchProvider()),
    ChangeNotifierProvider.value(value: CountiresProvider(),),
   // ChangeNotifierProvider.value(value: CheckOutProvider(),),
    ChangeNotifierProxyProvider<ShoppingCartProvider, CheckOutProvider>(
      update: (context, shoppingcart, prevcheckout) => CheckOutProvider(shoppingcart),
      create: (BuildContext context) => CheckOutProvider(null),
    ),
  ],
    child: MyApp(),));
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));

    SettingsServices settingsServices = locator<SettingsServices>();
    settingsServices.getUserSettings();

    return MaterialApp(
          title: 'Ecommerce App Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),

//          theme:(snapshot.data.darkMode!=null&&!snapshot.data.darkMode)?AppTheme.lightTheme.copyWith(
//            textTheme: GoogleFonts.muliTextTheme(
//              Theme.of(context).textTheme,
//            ),
//          ):
                  theme:AppTheme.lightTheme,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: router.generateRoute,
          initialRoute: routes.HomeRoute,
          debugShowCheckedModeBanner: false,
          //home: HomeView(),
        );


  }
}

