import 'package:flutter/material.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;
  final String image;
  final Widget customWidget;

  DialogRequest(
      {
      @required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.image,
      this.cancelTitle,
      this.customWidget
      });
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
