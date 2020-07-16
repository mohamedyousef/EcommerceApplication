import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/country.dart';
import 'package:ecommerceApp/Models/payment/card_model.dart';
import 'package:ecommerceApp/Models/shipping/shipping_method.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Views/PaymentProceed/model/shipping_mode.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ecommerceApp/Services/geo_services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

GeoServices geoServices = locator<GeoServices>();

class getCounteries extends StatelessWidget {
  TextEditingController controller;
  ValueChanged<Country> onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Country",

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              //   labelStyle: TextStyle(fontSize: 18,color: Colors.black),
            )),
        suggestionsCallback: (pattern) async {
          return await geoServices.searchCountryByName(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.name),
          );
        },
        onSuggestionSelected: (Country suggestion) async {
          controller.text = suggestion.name;
          onPressed(suggestion);
          //   print(suggestion.states);
        },
      ),
    );
  }

  getCounteries(this.controller, this.onPressed);
}

class getCities extends StatelessWidget {
  TextEditingController controller;
  String countryName;

  getCities(this.controller, this.countryName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            decoration: InputDecoration(
              labelText: "City",

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
              ),
              //   labelStyle: TextStyle(fontSize: 18,color: Colors.black),
            )),
        suggestionsCallback: (pattern) async {
          return await geoServices.getCitiesOfCountry(countryName, pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (String suggestion) async {
          controller.text = suggestion;
          //   print(suggestion.states);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class AddAddressScreen extends StatelessWidget {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  PhoneNumber _phoneNumber = PhoneNumber();
  Ing ing;

  void getPhoneNumber() async {
    _phoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(ing.phone);
    phoneNumber.text = _phoneNumber.parseNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ViewModelBuilder<ShippingViewModel>.reactive(
          onModelReady: (model) => getPhoneNumber(),
          viewModelBuilder: () => ShippingViewModel(),
          builder: (context, model, child) {
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: RawMaterialButton(
                          fillColor: Colors.black,
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              ing = Ing(
                                address1: address.text,
                                address2: address2.text,
                                city: cityController.text,
                                country: country.text,
                                phone: phoneNumber.text,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                postcode: zipCode.text,
                                state: state.text,
                              );

                              if (model.set_as_default) {
                                model.saveDataToFirebase(ing);
                              }

                              DataOP().insertAddressBook(ing,
                                  isdefault: model.set_as_default);

                              Navigator.pop(context, ing);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                    )),
              ),
              appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.black),
                  ),
                  title: Text("Add Address")),
              body: SingleChildScrollView(
                child: AnimatedContainer(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  duration: Duration(milliseconds: 300),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: textForm(firstName, "First Name",
                                  borderColor: Colors.grey.shade100)),
                          Flexible(
                              child: textForm(lastName, "Last Name",
                                  borderColor: Colors.grey.shade100)),
                        ],
                      ),
                      textForm(address, "Address 1",
                          borderColor: Colors.grey.shade100),
                      textForm(address2, "Address 2",
                          req: false, borderColor: Colors.grey.shade100),
                      textForm(state, "State (Optional)",
                          req: false, borderColor: Colors.grey.shade100),
                      getCounteries(country, (value) {
                        model.country = value;
                      }),
                      SizedBox(
                        height: 16,
                      ),
                      if (model.country != null)
                        Row(
                          children: <Widget>[
                            if (model.country.states != null &&
                                model.country.states.isNotEmpty)
                              Flexible(
                                  child: getCities(
                                      cityController, model.country.name)),
                            Flexible(
                                child: textForm(zipCode, "Post Code",
                                    req: false,
                                    borderColor: Colors.grey.shade100))
                          ],
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (value) {},
                        countrySelectorScrollControlled: true,
                        ignoreBlank: false,
                        autoValidate: false,
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: (_phoneNumber != null)
                            ? _phoneNumber
                            : PhoneNumber(isoCode: "EG"),
//            (model.country!=null)?PhoneNumber(isoCode: "${model.country.code}"):null,
                        textFieldController: phoneNumber,
                        inputDecoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        //inputBorder: OutlineInputBorder(),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Row(
                        children: <Widget>[
                          Switch(
                            value: model.set_as_default,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              model.set_as_default = value;
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Set as default",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700))
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class CreditCardRow extends StatelessWidget {
  CardModel _cardModel;
  CreditCardRow(this._cardModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          Image.asset(
            (_cardModel.brand.toLowerCase().contains("master card"))
                ? "assets/images/mastercard.png"
                : "assets/images/visa.png",
            height: 64,
            width: 64,
          ),
          Expanded(
              child: Text("${_cardModel.brand} ending ${_cardModel.last4}")),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}

class CardShippingMethod extends StatelessWidget {
//  int index;
  bool isActive;
  ShippingZoneMethod _shippingMethod;

  CardShippingMethod(this._shippingMethod, this.isActive);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: (isActive) ? Colors.black : Colors.transparent,width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text("desc"),
            Text("title"),
            Image.asset(
              "assets/images/",
              height: 64,
              width: 80,
            )
          ],
        ),
      ),
    );
  }
}
