import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Views/PaymentProceed/model/shipping_mode.dart';
import 'package:ecommerceApp/Views/PaymentProceed/widgets/widgets.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

class AddAddressBook extends StatelessWidget {
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
  NavigationService _navigationService = locator<NavigationService>();

  Ing ing;
  AddAddressBook({this.ing}) {
    if (ing != null) {
      firstName.text = ing.firstName;
      country.text = ing.country;
      cityController.text = ing.city;
      lastName.text = ing.lastName;
      address.text = ing.address1;
      address2.text = ing.address2;
      state.text = ing.state;
      zipCode.text = ing.postcode;
      //  phoneNumber.text = ing.phone.replaceAll("+", "");


    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ViewModelBuilder<ShippingViewModel>.reactive(
          viewModelBuilder: () => ShippingViewModel(),
          onModelReady: (model)async{
            if(ing!=null) {
              model.phoneNumberGl =
              await PhoneNumber.getRegionInfoFromPhoneNumber(ing.phone);
              model.set_as_default = ing.isDefault;
            }
          },
          builder: (context, model, child) {
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
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
                              }
                              if (ing == null)
                                DataOP().insertAddressBook(shipping,
                                    isdefault: model.set_as_default);
                              else {
                                shipping.id = ing.id;
                                DataOP().updateAddressBook(shipping,
                                    isdefault: model.set_as_default);
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(width: 10),
                      if (ing != null)
                        RawMaterialButton(
                            onPressed: () async {
                              int a = await DataOP().deleteAddress(ing.id);
                              print(a);
                              if (a != null && a > 0) Navigator.pop(context);
                            },
                            fillColor: Colors.red,
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            )),
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      _navigationService.goBack();
                    },
                    icon: Icon(Icons.chevron_left,
                        color: Colors.black, size: 30),
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
                        onInputChanged: (value) {
                           model.phoneNumber = value.phoneNumber;
                        },

                        countrySelectorScrollControlled: true,
                        ignoreBlank: false,
                        autoValidate: false,
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        selectorTextStyle: TextStyle(color: Colors.black),

                         initialValue: (model.phoneNumberGl != null)
                             ? model.phoneNumberGl:null,
                         //     PhoneNumber(isoCode: "EG"),
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
