import 'package:stacked/stacked.dart';

class OrderViewModel extends BaseViewModel{
  bool _showMore = false;

  bool get showMore => _showMore;

  set showMore(bool value) {
    _showMore = value;
    notifyListeners();
  }
}