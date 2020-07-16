import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Views/blog/widgets/widgets.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class WriteReviewViewModel extends BaseViewModel{
  Api _api =   locator<Api>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  Review _review ;
  Review get review => _review;

  set review(Review value) {
    _review = value;
    notifyListeners();
  }

  dynamic _rating=  3.0;
  dynamic get rating => _rating;

  set rating(dynamic value) {
    _rating = value;
    notifyListeners();
  }

  Future<void> getReview(int productId)async{
    setBusy(true);
    List<Review> reviews = await _api.getReviews(productId,filter: "reviewer_email=${_authenticationService.userData.email}");
    if(reviews!=null&&reviews.isNotEmpty)
    review = reviews[0];
    else
      _review = Review(productId: productId,reviewer:_authenticationService.userData.getFullName(),
      reviewerEmail: _authenticationService.userData.email,rating: _rating);
    setBusy(false);

    _rating  = review.rating;
    notifyListeners();
  }
  addReview(int productId,String comment)async{
    setBusy(true);
    review.review = comment;
    review.productId = productId;
    review.rating  = rating  ;

    print(productId);
    dynamic  response ;

    if(_review.dateCreated!=null)
      response = await _api.updateReview(review);
      else
     response = await _api.writeReview(review);
    setBusy(false);
    print(response);
    if(response!=null)
      navigatoionServices.goBack();
  }
}