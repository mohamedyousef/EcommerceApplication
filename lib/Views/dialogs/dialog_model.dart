import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;
  Widget child;


  DialogRequest(
      { this.title,
        this.description,
        this.buttonTitle,
        this.cancelTitle,this.child});
}



class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
