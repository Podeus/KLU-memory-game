import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }
  Future<dynamic> navigateToUntil(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
  void goBackUntil() {
    return navigatorKey.currentState.pop(false);
  }
  void goBackCanPop(routeName) {
    if(navigatorKey.currentState.canPop() == true){
      navigatorKey.currentState.pop(false);
    }else{
      navigatorKey.currentState.pushNamed(routeName);
    }
  }
}
