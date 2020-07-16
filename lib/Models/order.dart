import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'ShippingLine.dart';
import 'coupone.dart';

//
//class Order {
//  Order({
//    this.id,
//    this.customerID,
//    this.paymentMethod,
//    this.paymentMethodTitle,
//    this.setPaid,
//    this.billing,
//    this.shipping,
//    this.lineItems,
//    this.productCarts,
//    this.shippingLines,
//  });
//
//  String paymentMethod;
//  String paymentMethodTitle;
//  bool setPaid;
//  Ing billing;
//  Ing shipping;
//  int customerID;
//  int id;
//
//
//  List<LineItem> lineItems;
//  List<ProductCart>productCarts;
//
//  List<ShippingLine> shippingLines;
//
//  factory Order.fromJson(Map<String, dynamic> json) => Order(
//    id:json["id"],
//    customerID: json["customer_id"],
//    paymentMethod: json["payment_method"],
//    paymentMethodTitle: json["payment_method_title"],
//    setPaid: json["set_paid"],
//    billing: Ing.fromJson(json["billing"]),
//    shipping: Ing.fromJson(json["shipping"]),
//    lineItems: List<LineItem>.from(json["line_items"].map((x) => LineItem.fromJson(x))),
//    shippingLines: List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "customer_id":customerID,
//    "payment_method": paymentMethod,
//    "payment_method_title": paymentMethodTitle,
//    "set_paid": setPaid,
//    "billing": billing.toJson(),
//    "shipping": shipping.toJson(),
//    "line_items": List<dynamic>.from(productCarts.map((x) => x.toJson())),
//    "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x.toJson())),
//  };
//
//}
//

class Order {
  Order({
    this.id,
    this.parentId,
    this.number,
    this.orderKey,
    this.createdVia,
    this.version,
    this.status,
    this.currency,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.pricesIncludeTax,
    this.customerId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.dateCompleted,
    this.dateCompletedGmt,
    this.cartHash,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.currencySymbol,
    this.setPaid,
    this.productCarts,
  });

  bool setPaid;
  int id;
  int parentId;
  String number;
  String orderKey;
  String createdVia;
  String version;
  String status;
  String currency;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  bool pricesIncludeTax;
  int customerId;
  String customerIpAddress;
  String customerUserAgent;
  String customerNote;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  dynamic datePaid;
  dynamic datePaidGmt;
  dynamic dateCompleted;
  dynamic dateCompletedGmt;
  String cartHash;
  List<LineItem> lineItems;
  List<dynamic> taxLines;
  List<ShippingLine> shippingLines;
  List<dynamic> feeLines;
  List<Coupon> couponLines;
  List<dynamic> refunds;
  String currencySymbol;
  List<ProductCart> productCarts;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        parentId: json["parent_id"],
        number: json["number"],
        orderKey: json["order_key"],
        createdVia: json["created_via"],
        version: json["version"],
        status: json["status"],
        currency: json["currency"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        discountTotal: json["discount_total"],
        discountTax: json["discount_tax"],
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"],
        cartTax: json["cart_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        pricesIncludeTax: json["prices_include_tax"],
        customerId: json["customer_id"],
        customerIpAddress: json["customer_ip_address"],
        customerUserAgent: json["customer_user_agent"],
        customerNote: json["customer_note"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        transactionId: json["transaction_id"],
        datePaid: json["date_paid"],
        datePaidGmt: json["date_paid_gmt"],
        dateCompleted: json["date_completed"],
        dateCompletedGmt: json["date_completed_gmt"],
        cartHash: json["cart_hash"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        shippingLines: List<ShippingLine>.from(
            json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
        feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
     //   couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() {
    return{
      "customer_id": customerId,
      "payment_method": paymentMethod,
      "payment_method_title": paymentMethodTitle,
      "set_paid": setPaid,
      "billing": billing.toJson(),
      "shipping": shipping.toJson(),
      "line_items": List<dynamic>.from(productCarts.map((x) => x.toJson())),
      "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x.toJson())),
     "coupon_lines":List<dynamic>.from(couponLines.map((e) => e.toJson()))
    };

  }

  double subTotal() {
    double totalPrice = double.parse(total);
    double shippingPrice = double.parse(shippingTotal);
    if(double.parse(discountTotal)>0)
      return totalPrice;

    return totalPrice - shippingPrice;
  }
}

class OrderStatus {
  static final String pending = "pending";
  static final String processing = "processing";
  static final String cancelled = "cancelled";
  static final String refunded = "refunded";
  static final String failed = "failed";
  static final String completed = "completed";
  static final String trash = "trash";
  static final String on_hold = "on-hold";
}
