import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Views/PaymentProceed/model/shipping_mode.dart';
import 'package:ecommerceApp/Views/PaymentProceed/widgets/widgets.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

typedef VoidCallback onPressed(Ing ing);

class ShippingPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  bool isFromAddressList = true;
  onPressed onpressed;
  ShippingPage(this.onpressed, {this.isFromAddressList});

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController cityController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ViewModelBuilder<ShippingViewModel>.reactive(
          viewModelBuilder: () => ShippingViewModel(),
//          onModelReady: (model) {
//            model.load_default();
//            if (model.ing != null) {
//              firstName.text = model.ing.firstName;
//              country.text = model.ing.country;
//              cityController.text = model.ing.city;
//              lastName.text = model.ing.lastName;
//              state.text = model.ing.state;
//              zipCode.text = model.ing.postcode;
//             // phoneNumber.text = model.ing.phone;
//              getPhoneNumber();
//              model.phoneNumber = model.ing.phone;
//
//            }
//          },
          builder: (context, model, child) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 100),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (isFromAddressList)
                    Text(
                      "Step 1",
                      style: AppTheme.subTitleStyle,
                    ),
                  if (isFromAddressList)
                    Text(
                      "Shipping",
                      style: AppTheme.h2Style
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
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
                                req: false, borderColor: Colors.grey.shade100))
                      ],
                    ),
                  InternationalPhoneNumberInput(
                    onInputChanged: (value) {
                     model.phoneNumber = value.phoneNumber;
                    },
                    ignoreBlank: false,
                    autoValidate: false,
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: PhoneNumber(isoCode: "EG"),
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
                    height: 10,
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
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.black,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Ing shipping = Ing(
                            address1: address.text,
                            address2: address2.text,
                            city: cityController.text,
                            country: country.text,
                            phone: model.phoneNumber,
                            firstName: firstName.text,
                            lastName: lastName.text,
                            postcode: zipCode.text,
                            state: state.text,
                          );

                          if (model.set_as_default) {
                            model.saveDataToFirebase(shipping);
                            DataOP().insertAddressBook(shipping,
                                isdefault: model.set_as_default);
                          }

                          onpressed(shipping);
                        }
                      },
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("Continue to Payment",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
