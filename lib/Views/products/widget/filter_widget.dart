import 'package:async/async.dart';
import 'package:ecommerceApp/Models/AttrributeName.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/providers/filte_search_provider.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../locator.dart';

class FilterWidget extends StatelessWidget {

  Api api = locator<Api>();
  FilterSearchProvider provider;

  VoidCallback onPressed;

  FilterWidget(this.onPressed);
  AsyncMemoizer<List<AttributeName>> _asyncMemoizer = AsyncMemoizer();


  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FilterSearchProvider>(context);
    return FutureBuilder<List<AttributeName>>(
      future: _asyncMemoizer.runOnce(() => locator<Api>().getAllAttrubutes()),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.active||snapshot.connectionState==ConnectionState.done)
             provider.attributeItems = snapshot.data;

        return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 18,
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.black,
                            accentColor: LightColor.green_deep
                        ),
                        child: ExpansionTile(
                          title: Text("Sort By"),
                          initiallyExpanded: true,
                          children: <Widget>[
                            RadioListTile(
                              title: Text("New  Products"),
                              activeColor: Colors.black,
                              onChanged: (value) {
                                provider.selectedSort = value;
                              },
                              groupValue: provider.selectedSort,
                              value: 0,
                            ),
                            RadioListTile(
                              activeColor: Colors.black,
                              title: Text("Featured  Products"),
                              onChanged: (value) {
                                provider.selectedSort = value;
                              },
                              groupValue: provider.selectedSort,
                              value: 1,
                            ),
                            RadioListTile(
                              activeColor: Colors.black,
                              title: Text("On Sale "),
                              onChanged: (value) {
                                provider.selectedSort = value;
                              },
                              groupValue: provider.selectedSort,
                              value: 2,
                            )
                          ],
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.black,
                            accentColor: LightColor.green_deep
                        ),
                        child: ExpansionTile(
                          title: Text("Price Range"),
                          children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal:8.0),
//                  child: Row(
//                    children: <Widget>[
//                      Flexible(child: textForm(null, "From",textInputType: TextInputType.numberWithOptions(decimal: true,signed: false),req: false,function: (txt){
//                       if(double.parse(txt)<provider.endPrice)
//                        provider.startPrice = double.parse(txt);
//                      },borderColor: Colors.grey.shade100)) ,
//                      Flexible(child: textForm(null, "To",textInputType: TextInputType.numberWithOptions(decimal: true,signed: false),req:false,function:(txt){
//                        if(double.parse(txt)<provider.endPrice)
//                          provider.endPrice = double.parse(txt);
//
//                      },borderColor: Colors.grey.shade100)) ,
//                    ],
//                  ),
//                ),
//                SizedBox(
//                  height: 8,
//                ),
                            SizedBox(
                              height: 25,
                            ),
                            if (provider.endPrice != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "${provider.startPrice} ${provider
                                          .settingsServices.settings.currency}",
                                      style: AppTheme.subTitleStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black87),
                                    ),
                                    Text(
                                      "${provider.endPrice} ${provider
                                          .settingsServices.settings.currency}",
                                      style: AppTheme.subTitleStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 10),
                              child: RangeSlider(
                                min: 0,
                                max: 1000,
                                divisions: 10,
                                activeColor: Colors.black,
                                inactiveColor: Colors.grey.shade200,

                                values: RangeValues(
                                    provider.startPrice, provider.endPrice),
                                labels: RangeLabels(provider.startPrice.toString(),
                                    provider.endPrice.toString()),
                                onChanged: (value) {
                                  provider.startPrice = value.start;
                                  provider.endPrice = value.end;
                                  print(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.black,
                            accentColor: LightColor.green_deep
                        ),
                        child: ExpansionTile(
                          title: Text("Attributes"),
                          children: <Widget>[
                            if(snapshot.hasData)
                              Wrap(
                                children: <Widget>[
                                  for(var item in snapshot.data)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 500),
                                        child: (provider.id == item.id)
                                            ? RawMaterialButton(
                                          fillColor: Colors.black,
                                          onPressed: () {
                                            provider.id = item.id;
                                            provider.attributesIds.clear();
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                          child: Text("${item.name}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),),
                                        )
                                            :
                                        OutlineButton(
                                            highlightedBorderColor: Colors.black,
                                            onPressed: () {
                                              provider.id = item.id;
                                              provider.attributesIds.clear();
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20)),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            ),
                                            child: Text("${item.name}",
                                                style: TextStyle(color: Colors.black,
                                                    fontSize: 16))
                                        )
                                        ,
                                      ),
                                    ),
                                ],
                              ),
                            SizedBox(height: 10,),
                            if(provider.id != 0&&provider.attrs!=null&&provider.attrs.isNotEmpty)
                              Wrap(
                                runSpacing: 5,
                                spacing: 5,
                                children: <Widget>[
                                  for(var item in provider.attrs)
                                    AnimatedContainer(
                                      decoration: BoxDecoration(
                                          color: (provider.attributesIds.contains(
                                              item.id))
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      duration: Duration(milliseconds: 200),
                                      // padding: EdgeInsets.all(10),
                                      child: FlatButton(child: Text(item.name),
                                        onPressed: () {
                                          if (!provider.attributesIds.contains(
                                              item.id))
                                            provider.addAttributeToAttributes(
                                                provider.id, item);
                                          else {
                                            provider.removeFromAttribute(
                                                provider.id, item);
                                          }

                                        },),
                                    )

                                ],
                              )

//                        FutureBuilder(
//                          future:   api.getAttribute(provider.id),
//                          builder: (context,AsyncSnapshot<List<AttributeTerm>>data){
//                            print(data.data.toString());
//
//                            switch(data.connectionState){
//                              case ConnectionState.none:
//                              case ConnectionState.waiting:
//                                return Center(child:CircularProgressIndicator(
//                                  valueColor: AlwaysStoppedAnimation(
//                                    Colors.black
//                                  ),
//                                ));
//                                break;
//                              case ConnectionState.active:
//                              case ConnectionState.done:
//
//
//                                break;
//                            }
//
//                            return Container();
//                          },
//                        ),
                            ,SizedBox(height: 10,),
                          ],
                        ),
                      ),
//                  ExpansionTile(
//                    title: Text("Another Options"),
//                    children: <Widget>[
//                      ListTile(
//                        title: Text("On Sale") ,
//                        trailing: Switch(value: provider.onSale, onChanged: (value){
//                          provider.onSale = value;
//                        }),
//                      ),
//                      ListTile(
//                        title: Text("Featured"),
//                        trailing: Switch(value: provider.featured, onChanged: (value){
//                          provider.featured = value;
//                        }),
//                      ),
//
//                    ],
//                  ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlineButton(
                          child: Text("Clear",style: AppTheme.titleStyle,),
                          highlightedBorderColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            provider.clear();
                            onPressed();
                          },
                          borderSide: BorderSide(color: Colors.black,width: 1.5),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: RawMaterialButton(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Apply",
                                style: AppTheme.titleStyle.copyWith(color: Colors.white)),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            onPressed();
                          },
                          fillColor: Colors.black,
                          elevation: 3,
                        ),
                      ),
                      SizedBox(width: 10),

                    ],
                  ),
                )
              ],
            ));
      }
    );
  }
}
