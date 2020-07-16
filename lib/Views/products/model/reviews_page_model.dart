import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class ReviewPageModel extends BaseViewModel{

  Api _api = locator<Api>();
  List<Review> _reviews;
  List<Review> get reviews => _reviews;

  set reviews(List<Review> value) {
    _reviews = value;
    notifyListeners();
  }

  void getReviews(int productID)async{
    setBusy(true);
    _reviews  = await _api.getReviews(productID);
    setBusy(false);
  }

  void deleteReview(Review review)async{
    await _api.deleteReview(review.id);
    _reviews.remove(review);
    notifyListeners();
  }

  void addReview(Review review)async{
    _reviews.add(review);
    notifyListeners();
  }

}