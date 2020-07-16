import 'package:ecommerceApp/Models/country.dart';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/dialog_service.dart';
import 'package:ecommerceApp/Views/dialogs/dialog_widget.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class PaymentViewModel extends BaseViewModel{

  NavigationService navigationService  = locator<NavigationService>();
  AuthenticationService authenticationService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();


  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  User _user;




  User get user => _user;



//  set user(User value) {
//    _user = value;
//    notifyListeners();
//  }

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  void listenToUserRegisteration(){

//    Future.delayed(Duration(milliseconds: 200),(){
//      _dialogService.showCustomWidget(child: ExitConfirmationDialog());
//    });

    authenticationService.user.stream.listen((event) {
      if(event!=null) {
        _user =  event;
        print(event);
        notifyListeners();
      }else{
        _dialogService.showCustomWidget(child: ExitConfirmationDialog());
      }
      print(event);
    });
  }

}