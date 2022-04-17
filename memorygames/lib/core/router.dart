import'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/route_paths.dart' as routes;
import 'package:flutter_base/view/game/view/game_view.dart';
import 'package:flutter_base/view/home/view/home_view.dart';
import 'package:flutter_base/view/select/view/select_view.dart';


// import 'package:flutter_base/view/authenticate/signup/signupPage.dart';
// import 'package:flutter_base/view/authenticate/login/profilePage.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  // print("settings ${settings}");
  switch (settings.name) {
    case routes.homeRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case routes.selectRoute:
      return MaterialPageRoute(builder: (context) => SelectView());
    case routes.gameRoute:
      var newDatas = json.decode(json.encode(settings.arguments));
      var name = newDatas["name"] !=null ? newDatas["name"] : "";
      var level = newDatas["level"] !=null ? newDatas["level"] : "";
      return MaterialPageRoute(builder: (context) => GameView(name:name,level:level));

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
