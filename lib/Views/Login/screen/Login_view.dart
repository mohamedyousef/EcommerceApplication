import 'package:ecommerceApp/Views/Login/model/login_model.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {

  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginModel>.reactive(builder: (context,model,child)=>Scaffold(
      backgroundColor: ColorsStyles.coffe_color_Grey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
                    height: ScreenUtils.screenHeight(context,size: 0.13),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:23.0),
                    child: Text("Log in to",style: AppTheme.h1Style.copyWith(fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:23.0),
                    child: Text("your account",style: AppTheme.h1Style.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0),
                            child: textForm(emailTxt, "Email",textInputType: TextInputType.emailAddress),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(child: textForm(passwordTxt, "Password",obsecure: true)),
                                FlatButton(
                                  onPressed: (){
                                    model.navigationService.navigateTo(PasswordRoute);
                                  },
                                  child: Text("Forget?",style:AppTheme.titleStyle.copyWith(color: Colors.black87)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(model.errorLogin!=null&&model.errorLogin.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(model.errorLogin,style:AppTheme.titleStyle),
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
                      onPressed: (){
                        if(formKey.currentState.validate())
                          {
                            model.loginByEmail(emailTxt.text, passwordTxt.text);
                          }
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      child: Text("Log In",style: TextStyle(color:Colors.white,
                          fontSize: 17,fontWeight: FontWeight.bold),),
                     ),
                  )
//                ,SizedBox(height: 15,),
//                  Container(
//                    width: double.infinity,
//                    height: 50,
//                    margin: EdgeInsets.symmetric(horizontal: 25),
//                    child: RawMaterialButton(
//
//                      fillColor: Colors.white,
//                      shape: RoundedRectangleBorder(side: BorderSide(
//                        color: Colors.black,
//                        width: 1
//                      ),borderRadius: BorderRadius.circular(25)),
//
//                      onPressed: (){
//                        model.navigationService.navigateTo(RegisterRoute);
//                      },
//                      child: Text("Create Account With Email",
//                        style: TextStyle(color:Colors.black,fontSize: 16),),
//                    ),
//                  ),
                  ,SizedBox(height: ScreenUtils.screenHeight(context,size:0.04),),
                  Center(child: Text("OR",style: TextStyle(color:Colors.black,
                      fontSize: 14,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 15,),

              Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: RawMaterialButton(
                            onPressed: (){},
                            elevation: 1,
                            fillColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.2),
                              child: Icon(MdiIcons.facebook,color: Colors.white,),
                            ),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: RawMaterialButton(
                            fillColor: Colors.white,
                            elevation: 1,
                            onPressed: (){

                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.2),
                              child: Icon(MdiIcons.google,color: Colors.black,),
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


          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.5),
              child: FlatButton(
                onPressed: (){
                  model.navigationService.navigateTo(RegisterRoute);
                },
                child: Row(
                  children: <Widget>[
                    Text("Don't have an Account?  " ,style:TextStyle(fontSize: 15)),
                    Text("SignUp" ,style:TextStyle(fontSize: 16,decoration:TextDecoration.underline)),

                  ],
                ),
              ),
            ),
          ),

          Positioned(left: 5,top: 30,child:IconButton(
              onPressed: ()=>model.navigationService.goBack(),
              icon:Icon(Icons.chevron_left,color:Colors.black,size: 32,)
          )),
          if(model.isBusy)
          Positioned.fill(child: AnimatedOpacity(opacity: 0.7,duration: Duration(milliseconds: 500),
          child: Container(color:ColorsStyles.coffe_color_Grey))),
          if(model.isBusy)
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    ), viewModelBuilder: ()=>LoginModel());
  }
}
