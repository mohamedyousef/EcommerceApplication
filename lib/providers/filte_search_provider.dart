import 'package:ecommerceApp/Models/AttrributeName.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/locator.dart';
  import 'package:flutter/cupertino.dart';

class FilterSearchProvider extends ChangeNotifier {
  SettingsServices settingsServices = locator<SettingsServices>();
  Api _api = locator<Api>();
 // Map<int, List<AttributeTerm>> attributes = Map<int, List<AttributeTerm>>();

  List<AttributeName> _attributeItems = List<AttributeName>();
  List<AttributeName> get attributeItems => _attributeItems;

  int _selectedSort = 0;
  int _id = - 1 ;
  double _startPrice = 0, _endPrice = 1000;
  List<int>  attributesIds = List<int>();
  List<AttributeTerm>attrs;

  set attributeItems(List<AttributeName> attributeName){
    this._attributeItems = attributeName;
   // notifyListeners();
  }

  String getAttributesIds(){
    String attributes = "";
    for (int i in attributesIds)
      attributes += "$i,";
      return attributes;
  }

void loadAttrs()async{
  attrs = await _api.getAttribute(id);
  notifyListeners();
}


 // bool _onSale = false, _featured=false;
 // bool _averageRating,_popular;
//
//  get popular => _popular;
//
//  set popular(value) {
//    _popular = value;
//    _averageRating = false;
//    notifyListeners();
//  }

//  set attributeItems(List<AttributeName> value) {
//    _attributeItems = value;
//    notifyListeners();
//  }

  int get id => _id;

  set id(int value) {
    _id = value;
    loadAttrs();
    notifyListeners();
  } //  List<AttributeTerm>_currentAttributeTerms;
//  List<AttributeTerm> get currentAttributeTerms => _currentAttributeTerms;
//
//  set currentAttributeTerms(List<AttributeTerm> value) {
//    _currentAttributeTerms = value;
//    notifyListeners();
//  }


  int get selectedSort => _selectedSort;

  set selectedSort(int value) {
    _selectedSort = value;
    notifyListeners();
  }


  double get startPrice => _startPrice;

  set startPrice(double value) {
    _startPrice = value;
    notifyListeners();
  }

  get endPrice => _endPrice;

  set endPrice(value) {
    _endPrice = value;
    notifyListeners();
  }

  void addAttributeToAttributes(int id, AttributeTerm value) {
    //if(attributes.containsKey(id)) {
   //   attributes[id].add(value);
      attributesIds.add(value.id);
   // }

    notifyListeners();
  }

  void removeFromAttribute(int id, AttributeTerm value) {
  //  attributes[id].remove(value);
    attributesIds.remove(value.id);
    notifyListeners();
  }

 // bool get onSale => _onSale;


//
//  bool get averageRating => _averageRating;
//
//  set averageRating(bool value) {
//    _averageRating = value;
//    _popular = false;
//    notifyListeners();
//  }


//  getAttributeData()async{
//// if(attributeItems==null)
////      attributeItems = await _api.getAllAttrubutes();
////      print(attributeItems);
//
//    return await _api.getAllAttrubutes();
////        .then((value) =>
////    {
////      print(value.toString()),
////      for(var item in value)
////        attributes[item.id] = List()
////    }
//   // );
//  }

  void clear(){
    _endPrice = 1000;
    _startPrice = 0;
  //  _averageRating = null;
    _selectedSort = 0;
    attributesIds.clear();
    _id = -1;

  //  _averageRating = false;
  //  _popular = false;
    notifyListeners();
  }
}
