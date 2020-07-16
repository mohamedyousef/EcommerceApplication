import 'package:ecommerceApp/Models/image.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class ProductViewModel extends BaseViewModel{

  Api api =  locator<Api>();
  NavigationService navigationService = locator<NavigationService>();
  SettingsServices settingsServices =  locator<SettingsServices>();

  List<Variation> _variations=  List<Variation>();
  List<Variation> get variations => _variations;
  List<Image> images = List();

  Variation _variation;
  Variation get variation => _variation;
  set variation(Variation value) {
    _variation = value;
    notifyListeners();
  }
  int _index=0;
  int _pageIndex= 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  /* get variation by selected values */
  Map<int,DefaultAttribute> _selected=Map();
  Map<int,DefaultAttribute> get selected => _selected;


  int get index => _index;
  set index(int value) {
    _index = value;
    notifyListeners();
  }

  void addToSelected(DefaultAttribute defaultAttribute){
    this._selected[defaultAttribute.id]= defaultAttribute;
    notifyListeners();
  }

  requestData(int productID)async{
   _variations =  await api.getVariations(productID);
   for (var item in _variations)
     images.add(item.image);
  }

  getVariation({List<DefaultAttribute> variationAttribute}){
    Variation selectedVar ;

    Map<String,dynamic>variationsDataSelected= {
//    "name":option,
//    "size":option
    };

    if(variationAttribute!=null)
      variationAttribute.toList().forEach((element) {
        variationsDataSelected[element.name]=element.option.toLowerCase();
      });

    else
    _selected.values.toList().forEach((element) {
      variationsDataSelected[element.name]=element.option.toLowerCase();
    });

    _variations.forEach((element) {
      Map<String, dynamic> tmpVariations = {};
      element.attributes.forEach((element) {
        tmpVariations[element.name]=element.option.toLowerCase();
      });


      if (tmpVariations.toString() == variationsDataSelected.toString()) {
        selectedVar = element;
      }
    });

    this._variation = selectedVar;
    notifyListeners();
  }

  Future<void> init(Product product)async{
    images.addAll(product.images);
    if(product.variations.isEmpty) return;
    setBusy(true);


   await requestData(product.id);
    print(variations.toString());
    if(variations!=null&&variations.isNotEmpty) {
     await getVariation(variationAttribute: product.defaultAttributes);

     product.defaultAttributes.forEach((element) {
       _selected[element.id] = element;
     });

     notifyListeners();
     setBusy(false);
   }

  }

}