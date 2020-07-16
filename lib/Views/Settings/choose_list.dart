import 'package:ecommerceApp/Views/Settings/view_models/choose_list_view_models.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChooseList extends StatelessWidget {

  int page;
  ChooseList(this.page);
  TextEditingController searchText = TextEditingController();
  FocusNode focuseNode =  FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChooseListViewModel>.reactive(
        onModelReady: (model)=>model.loadCurrencies(),
        builder: (context,model,child){
      return Scaffold(
        backgroundColor: Colors.white,
        
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      model.navigationService.goBack();
                    },
                    icon: Icon(Icons.chevron_left,color: Colors.black,size: 32,),
                  ),
                  Expanded(
                    child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 16,
                            ),
                            Icon(Icons.search, color: Colors.black),
                            Flexible(
                              child: TextField(
                                onSubmitted: (value){
                                  searchText.text = value;
                                  focuseNode.unfocus();
                                  model.search(value);
                                },
                                focusNode: focuseNode,
                                style: TextStyle(fontSize: 16),
                                controller: searchText,
                                decoration: InputDecoration(
                                  hintText: "search",
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 25),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onChanged: (value){
                                  model.search(value);
                                },
                              ),
                            ),
                            IconButton(onPressed: (){
                              focuseNode.unfocus();
                              searchText.text = "";
                            },icon:Icon(Icons.close), color: Colors.black),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Recent currency",style: AppTheme.h3Style.copyWith(fontWeight: FontWeight.w800),),
                   Container(
                      child: Text("${model.currency}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              (model.currencies!=null)? Expanded(
                child: ListView.separated(itemBuilder: (context,index){
                  return ListTile(
                    trailing: (model.currency==model.currencies[index].currency)?Icon(Icons.check):null,
                    subtitle:Text(model.currencies[index].country,),
                    title: Text(model.currencies[index].currency,style:TextStyle(fontWeight: FontWeight.bold)),
                    onTap: (){
                      model.currency = model.currencies[index].currency;
                      model.settingsServices.changeCurrency(model.currencies[index].currency);
                    },
                  );
                }
                ,itemCount:model.currencies.length,
                  separatorBuilder: (BuildContext context, int index)=>Divider(),),
              ):Container()
            ],
          ),
        ),
      );
    }, viewModelBuilder: ()=>ChooseListViewModel());
  }
}
