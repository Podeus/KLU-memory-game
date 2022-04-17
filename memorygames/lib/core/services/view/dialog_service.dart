import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/services/model/dialog_models.dart';
// import 'package:fluttertoast/fluttertoast.dart';
class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String image,
    String buttonTitle = 'Tamam',
    Widget customWidget,
  }) {
    print("geldi");
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
      image: image,
      customWidget: customWidget,
    ));
    return _dialogCompleter.future;
  }
  // Future<DialogResponse> showToast({String title,String location,Color color}) {
  //   Fluttertoast.showToast(
  //       msg: title,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: location ==null ? ToastGravity.BOTTOM : ToastGravity.CENTER,
  //       backgroundColor: color == null ? Color(0xFF26B13C) : color,
  //       textColor: Colors.white,
  //       fontSize: 12.0);
  // }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog(
      {String title,
      String description,
      String image,
      String confirmationTitle = 'Tamam',
      String cancelTitle = 'İptal'}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        image: image,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle));
    return _dialogCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
