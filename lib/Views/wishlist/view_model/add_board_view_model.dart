import 'package:ecommerceApp/constants/suggested_name.dart';
import 'package:stacked/stacked.dart';

class AddBoardViewModel extends BaseViewModel{

  List<String> suggestedNames =  suggestedNameBorads;

  void search(String pattern){
    suggestedNames =  suggestedNameBorads.where((element) => element.toLowerCase()
        .startsWith(pattern.toLowerCase())).take(4).toList();
    notifyListeners();
  }

}