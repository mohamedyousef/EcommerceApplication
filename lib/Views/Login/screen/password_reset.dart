import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Views/Login/model/password_reset_view_model.dart';

class PasswordReset extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PasswordResetViewModel>.reactive(
      viewModelBuilder: ()=>PasswordResetViewModel(),
      builder: (context, model,child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:28.0),
                          child: Text("Forget Password ? ",style:AppTheme.h1Style,),
                        ),
                        SizedBox(height: 16,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:28.0),
                          child: Text("if you need help resetting your password, \nwe can help by sending you a link reset? ",
                            style:AppTheme.subTitleStyle.copyWith(fontSize: 15),),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: textForm(_textEditingController, "Email",
                              borderColor: Colors.grey.shade200
                              ,margin: 6,padding: 6,textInputType: TextInputType.emailAddress),
                        ),
                        if(model.errorMsg!=null&&model.errorMsg.isNotEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(model.errorMsg,style:AppTheme.titleStyle),
                            ),
                          ),

                        SizedBox(height: 16,),
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
                                model.resetPassword(_textEditingController.text);
                              }
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Text("Send",style: TextStyle(color:Colors.white,
                                fontSize: 17,fontWeight: FontWeight.bold),),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),

              if(model.isBusy)
                Positioned.fill(child: AnimatedOpacity(opacity: 0.7,duration: Duration(milliseconds: 500),
                    child: Container(color:Colors.white))),
              if(model.isBusy)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
        );
      }
    );
  }
}
