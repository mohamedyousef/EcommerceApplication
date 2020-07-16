import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'package:ecommerceApp/Views/wishlist/view_model/add_board_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class AddBoardScreen extends StatelessWidget {

  TextEditingController boardTitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBoardViewModel>.reactive(
      viewModelBuilder: ()=>AddBoardViewModel(),
      builder: (context, model,child){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading:   IconButton(
              icon: Icon(CupertinoIcons.left_chevron),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title:  Text("CREATE BOARD "),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 14),
                    child: TextFormField(
                      controller: boardTitle,
                      onChanged: (value){
                        model.search(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Enter a name for this board"
                      ),
                    ),
                  ),
                  SizedBox(height: 18,),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:14.0),
                      child: Text("SUGGESTED NAMES :",style: GoogleFonts.roboto()
                          .copyWith(fontSize: 17,color: Colors.black87,fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context,index){
                      return Align(
                        alignment: Alignment.topLeft,
                        child: FlatButton(
                          child: Text(model.suggestedNames[index],style: TextStyle(fontSize: 16,color: Colors.grey.shade600),),
                          onPressed: ()async{
                            boardTitle.text = model.suggestedNames[index];
                          },
                        ),
                      );

                    },
                    itemCount: model.suggestedNames.take(3).length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(8),
                    child: RawMaterialButton(
                      fillColor: Colors.black,
                      onPressed: () async{
                        if(_formKey.currentState.validate()) {
                          await DataOP().saveBoard(Board(boardTitle.text));

                          Fluttertoast.showToast(
                              msg:  " Board Created Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );


                          Navigator.pop(context);
                        }


                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:13,vertical: 14),
                        child: Text(
                          "Create Board",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
