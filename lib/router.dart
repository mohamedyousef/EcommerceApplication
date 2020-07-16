import 'package:ecommerceApp/Views/Categories/screens/ListAllCateogires.dart';
import 'package:ecommerceApp/Views/Login/screen/Register_view.dart';
import 'package:ecommerceApp/Views/Login/screen/password_reset.dart';
import 'package:ecommerceApp/Views/PaymentProceed/screen/congrats.dart';
import 'package:ecommerceApp/Views/PaymentProceed/screen/payment_page/add_credit_card.dart';
import 'package:ecommerceApp/Views/PaymentProceed/screen/payment_page/payment_page.dart';
import 'package:ecommerceApp/Views/PaymentProceed/screen/shipping/choose_address.dart';
import 'package:ecommerceApp/Views/PaymentProceed/widgets/widgets.dart';
import 'package:ecommerceApp/Views/Settings/choose_list.dart';
import 'package:ecommerceApp/Views/blog/screens/show_posts.dart';
import 'package:ecommerceApp/Views/products/screens/pages/reviews/write_review_page.dart';
import 'package:ecommerceApp/Views/products/screens/product_screen.dart';
import 'package:ecommerceApp/Views/wishlist/screens/add_board_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Notifications/notification.dart';
import 'Views/Login/screen/Login_view.dart';
import 'Views/PaymentProceed/screen/payment_page/credit_card_option.dart';
import 'Views/account/screens/add_address_screen.dart';
import 'Views/blog/screens/post_details.dart';
import 'Views/photoGallery/photogallery.dart';
import 'Views/products/screens/list_products_category.dart';
import 'Views/products/screens/show_products.dart';
import 'Views/search/screens/search_screen.dart';
import 'Views/wishlist/screens/board_screen.dart';
import 'constants/route_path.dart' as routes;
import 'package:ecommerceApp/Views/Settings/SettingsScreen.dart';
import 'package:ecommerceApp/Views/account/screens/add_address_screen.dart';
import 'package:ecommerceApp/Views/account/screens/address_book_screen.dart';
import 'package:ecommerceApp/Views/PaymentProceed/screen/payment_page/paypal_payment_widget.dart';
import 'package:ecommerceApp/Views/account/screens/orders/my_order.dart';
import 'package:ecommerceApp/Views/account/screens/orders/my_orders.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginView());
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => NotificationHandler());
    case routes.ProductsRoute:
      return MaterialPageRoute(
          builder: (context) => ListProducts(settings.arguments));
    case routes.ProductRoute:
      return CupertinoPageRoute(
          builder: (context) => ProductDetails(settings.arguments));

    case routes.PhotoGallery:
      return MaterialPageRoute(
          builder: (context) => GalleryScreen(settings.arguments));

//    case routes.PaymentProceed:
//      return MaterialPageRoute(
//          builder: (context) => DialogManager(child: PaymentProceedScreen()));

    case routes.SearchRoute:
      return MaterialPageRoute(builder: (context) => SearchScreen());

    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginView());

    case routes.PasswordRoute:
      return CupertinoPageRoute(builder: (context) => PasswordReset());

    case routes.RegisterRoute:
      return CupertinoPageRoute(builder: (context) => RegisterView());

    case routes.ViewAllCats:
      return CupertinoPageRoute(builder: (context) => ListViewAllCategories());

    case routes.SettingsRoute:
      return CupertinoPageRoute(
          builder: (context) => SettingsScreen(settings.arguments));

    case routes.ChooseSettingsRoute:
      return CupertinoPageRoute(
          builder: (context) => ChooseList(settings.arguments));

    case routes.AddressBookRoute:
      return CupertinoPageRoute(builder: (context) => AddressBookScreen());

    case routes.AddAddressBookRoute:
      return MaterialPageRoute(
          builder: (context) => AddAddressBook(
                ing: settings.arguments,
              ));

    case routes.AddBoradRoute:
      return CupertinoPageRoute(builder: (context) => AddBoardScreen());
    case routes.BoradRoute:
      return MaterialPageRoute(
          builder: (context) => BoardScreen(settings.arguments));
    case routes.AddressChooseRoute:
      return MaterialPageRoute(
          builder: (context) => ChooseAddress());
    case routes.CongratsRoute:
      return  CupertinoPageRoute(
          builder: (context) => CongratsScreen());

    case routes.PaymentChooseRoute:
      return CupertinoPageRoute(
          builder: (context) => PaymentChooseScreen());
    case routes.PaypalPaymentRoute:
      return CupertinoPageRoute(
          builder: (context) => PaypalPayment());

    case routes.CreditCardChooseRoute:
      return CupertinoPageRoute(
          builder: (context) => ChooseCreditCardScreen());

    case routes.AddCreditCardRoute:
      return MaterialPageRoute(
          builder: (context) => AddCreditCard());

    case routes.AddAddressesRoute:
      return MaterialPageRoute(
          builder: (context) => AddAddressScreen());

    case routes.BlogRoute:
      return MaterialPageRoute(
          builder: (context) => ShowPostsScreen());

    case routes.PostDetailsRoute:
      return CupertinoPageRoute(
          builder: (context) => PostDetailsScreen(settings.arguments));

    case routes.ViewAllProductsBySubCatRoute:
      return MaterialPageRoute(
          builder: (context) => ListProductsByCategory(settings.arguments));

    case routes.MyOrdersRoute:
      return CupertinoPageRoute(
          builder: (context) => MyOrdersScreen());
    case routes.WriteReviewRoute:
      return MaterialPageRoute(
          builder: (context) => WriteReviewScreen(settings.arguments));

    case routes.OrderRoute:
      return CupertinoPageRoute(
          builder: (context) => OrderScreen(settings.arguments));

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
