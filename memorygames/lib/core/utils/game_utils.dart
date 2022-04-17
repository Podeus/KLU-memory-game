import 'dart:math';

import 'package:flutter/material.dart';

class Game{

  final Color hiddenCard = Colors.red;
  List<Color> gameColors;
  List<String> gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "assets/images/hidden.png";


  List<String> cards_list1 = [
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/heart.png",
    "assets/images/6gen.png",
    "assets/images/8gen.png",
    "assets/images/6gen.png",
    "assets/images/8gen.png",

    "assets/images/aslan.png",
    "assets/images/zurafa.png",
    "assets/images/aslan.png",
    "assets/images/zurafa.png",
  ];

  List<String> cards_list2 = [
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/heart.png",
    "assets/images/6gen.png",
    "assets/images/8gen.png",
    "assets/images/6gen.png",
    "assets/images/8gen.png",

    "assets/images/aslan.png",
    "assets/images/zurafa.png",
    "assets/images/zebra.png",
    "assets/images/yilan.png",
    "assets/images/timsah.png",
    "assets/images/penguen.png",
    "assets/images/maymun.png",
    "assets/images/kaplan.png",
    "assets/images/gergedan.png",
    "assets/images/fil.png",
    "assets/images/deve.png",
    "assets/images/ayi.png",
    "assets/images/deve.png",
    "assets/images/fil.png",
    "assets/images/gergedan.png",
    "assets/images/kaplan.png",
    "assets/images/maymun.png",
    "assets/images/penguen.png",
    "assets/images/timsah.png",
    "assets/images/yilan.png",
    "assets/images/zebra.png",
    "assets/images/zurafa.png",
    "assets/images/ayi.png",
    "assets/images/aslan.png",
  ];

  List<String> cards_list = [];
  // final int cardCount = 8;
  List<Map<int, String>> matchCheck = [];
  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
  //methods
  void initGame(cardCount) {
    if(cardCount==16){
      cards_list = shuffle(cards_list1);
    }else if(cardCount==36){
      cards_list = shuffle(cards_list2);
    }
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
