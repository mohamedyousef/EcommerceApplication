import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Models/ShippingLine.dart';
import 'package:ecommerceApp/Models/coupone.dart';
import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("Products", (){
    setUpAll(()=>setupLocator());
    test('Constructing Service should find correct dependencies', ()async{
     // final data = await Api().saveCustomer(User(username: "mohamedyousef99",email: "mohamedyousef16@gmail.com",
//          lastName: "mohamed",
//          firstName: "mohamed"));
   //   print(data);

//    Order order = Order(
//      discountTotal: "200",
//      billing: Ing(
//        email: "mohamedyousef106@gmail.com",
//        address2: "66 ",
//        address1: "ismailia",
//        city: "ismailia",
//        firstName: "mohamed",
//        lastName: "yousef",
//        phone: "01141489965",
//        state: "ismailia",
//        postcode: "41528", country: "Egypt"
//      ),
//      shipping: Ing(
//        email: "mohamedyousef106@gmail.com",
//        address2: "66 ",
//        address1: "ismailia",
//        city: "ismailia",
//        firstName: "mohamed",
//        lastName: "yousef",
//        phone: "01141489965",
//        state: "ismailia", postcode: "41528",
//        country: "Egypt"
//      ),
//      productCarts: [
//        ProductCart(
//          Product(id: 44,name: "necklace",price: "45"), null, 5)
//      ],
//      couponLines: [
//        Coupon(
//          id: 99,
//          code: "myousef",
//          amount : "10.00",
//        )
//      ],
//        shippingLines: [
//          ShippingLine(
//              methodId: "flat_rate",
//              methodTitle: "Flat rate",
//              total: "10.00" )
//        ]
//    );

//    final data = await locator<Api>().writeReview(Review(
//      productId: 72,
//      rating: 3,
//      review: "Good",
//      reviewer: "mohamedyousef106",
//      reviewerEmail: "mohamedyousef106@gmail.com"
//    ));

    final data = await locator<Api>().getReviews(72);
    print(data);
 //   print(data);
  //  print(data[0].settings.cost.toJson());
//    for(var item in data)
//      if(item.settings.cost!=null)
//      print(item.settings.cost.toJson());


//    for(var item in data)
//      if(item.settings.minAmount!=null)
//    print(item.settings.minAmount.toJson());

//    print(data);

//     dynamic data  = await convertCurrencyFree(
//       fromCurrency: "EGP",
//       toCurrency: "USD",
//     );
//     print("Result ${data.toString()}");

   // print(data[0].id);

//      print(postService.toList());

    //   final postService = await Api().getVariations(14);
//      List<DefaultAttribute>attrs = List();
//
//      attrs.add(DefaultAttribute(
//        id:3,
//        name:"Colors" ,
//        option: "black",
//      ));
//      attrs.add(DefaultAttribute(
//        id:2,
//        name:"Size" ,
//        option: "small",
//      ));
//
//      Variation selectedVar ;
//
//      Map<String,dynamic>variationsDataSelected= {
////    "name":option,
////    "size":option
//      };
//
//      attrs.forEach((element) {
//        variationsDataSelected[element.name]=element.option.toLowerCase();
//      });
//
//      postService.forEach((element) {
//        Map<String, dynamic> tmpVariations = {};
//        element.attributes.forEach((element) {
//          tmpVariations[element.name]=element.option.toLowerCase();
//        });
//
//
//        if (tmpVariations.toString() == variationsDataSelected.toString()) {
//          selectedVar = element;
//        }
//      });
//
//      print(selectedVar.toJson().toString());

//      String attr = "";
//      for (var item in attrs)
//        attr += item.name +",";
//
//for(var item in postService)
//  print(item.attributes.first.option.toString());




//      for (var item in postService) {
//        for(var attr in item.attributes)
//          if(attrs.contains(attr))
//            variation =  item ;
//
//        break;
//      }


       expect(data != null, true);
    });

  });


  //  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
}
