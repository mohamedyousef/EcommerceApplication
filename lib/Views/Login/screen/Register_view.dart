import 'package:ecommerceApp/Views/Login/model/register_view_model.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            //resizeToAvoidBottomInset: false,
           //resizeToAvoidBottomPadding: false,
            backgroundColor: LightColor.coffer_light_grey,
            body: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtils.screenHeight(context, size: 0.13),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: Text(
                            "Create your ",
                            style: AppTheme.h1Style
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: Text("account with email",
                              style: AppTheme.h1Style
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: textForm(emailTxt, "Email",
                                      textInputType:
                                          TextInputType.emailAddress,margin: 2,padding: 2),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: textForm(passwordTxt, "Password",
                                      obsecure: true,margin: 2,padding: 2),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: textForm(
                                      confirmPassword, "Confirm Password",
                                      obsecure: true,margin: 2,padding: 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (model.errorRegister != null &&
                            model.errorRegister.isNotEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(model.errorRegister,
                                  style: AppTheme.titleStyle),
                            ),
                          ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: RawMaterialButton(
                            elevation: 8,
                            fillColor: Colors.black,
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                if (passwordTxt.text
                                    .contains(confirmPassword.text))
                                  model.registerWithEmail(
                                      emailTxt.text, passwordTxt.text);
                                else
                                  model.errorRegister = "Password Not Matches";
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtils.screenHeight(context, size: 0.04),
                        ),
                        Center(
                            child: Text(
                          "Or sign up with social account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 1,
                                  fillColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.2),
                                    child: Icon(
                                      MdiIcons.facebook,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: RawMaterialButton(
                                  fillColor: Colors.white,
                                  elevation: 1,
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.2),
                                    child: Icon(
                                      MdiIcons.google,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                Positioned(
                    left: 5,
                    top: 30,
                    child: IconButton(
                        onPressed: () => model.navigationService.goBack(),
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 32,
                        ))),
                if (model.isBusy)
                  Positioned.fill(
                      child: AnimatedOpacity(
                          opacity: 0.7,
                          duration: Duration(milliseconds: 500),
                          child:
                              Container(color: LightColor.coffer_light_grey))),
                if (model.isBusy)
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          );
        });
  }
}
