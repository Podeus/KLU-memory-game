import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/components/game/info_card.dart';
import 'package:flutter_base/core/locator.dart';
import 'package:flutter_base/core/services/view/navigation_service.dart';
import 'package:flutter_base/core/constants/route_paths.dart' as routes;
import 'package:flutter_base/core/utils/game_utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
class GameView extends StatefulWidget {
  String level;
  String name;
  GameView({this.level,this.name});
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  //setting text style
  TextStyle whiteText = TextStyle(color: Colors.white);
  bool hideTest = false;
  Game _game = Game();

  //game stats
  int tries = 0;
  int score = 0;
  int cardCount = 0;
  int eslesmesol = 0;
  int eslesmesag = 0;


  Timer _timer;
  String greeting;
  Duration duration1 = Duration();
  static var countdownDuration1 = Duration(minutes: 1);
  Timer timer1;
  bool countDown1 = true;

  var toplamsure = 0;
  var hours1;
  var mints1;
  var secs1;
  @override
  void initState() {
    super.initState();
    yeniOyun();
    setState(() {
      eslesmesol=0;
      eslesmesag= ((cardCount ) ~/ 2);
    });

    hours1 = int.parse("00");
    if(widget.level=="1"){
      mints1 = int.parse("02");
      toplamsure = 120;
    }else{
      mints1 = int.parse("03");
      toplamsure = 180;
    }
    secs1 = int.parse("00");
    countdownDuration1 =
        Duration(hours: hours1, minutes: mints1, seconds: secs1);
    startTimer1();
    reset1();
  }
  @override
  void dispose() {
    reset1();
    // TODO: implement dispose
    super.dispose();
  }

  void startTimer1() {
    timer1 = Timer.periodic(Duration(seconds: 1), (_) => addTime1());
  }
  void reset1() {
    try{
      if (countDown1) {
        setState(() => duration1 = countdownDuration1);
      } else {
        setState(() => duration1 = Duration());
      }
    }catch(e) {
      print(e);
    }
  }
  void addTime1() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration1.inSeconds - addSeconds;
      if (seconds < 0) {
        timer1.cancel();
      } else {
        duration1 = Duration(seconds: seconds);
      }
    });
  }
  Future<bool> _onWillPop() async {
    final isRunning = timer1 == null ? false : timer1.isActive;
    if (isRunning) {
      timer1.cancel();
    }
    // Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }
  Widget buildTimeCard({ String time,  String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: duration1.inSeconds == 0 ? Colors.red :Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: duration1.inSeconds == 0 ? Colors.yellow :Colors.black,
                  fontSize: 15),
            ),
          ),
        ],
      );
  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }
  Future<bool> insertUserScore (int time, int score) async {
    int result = 0;
    final database = openDatabase(
      join(await getDatabasesPath(), 'score_database.db'),
    );
    final db = await database;
    try {
      result = await db.rawInsert(
          'INSERT INTO game_scores (name, time, score,created_at) VALUES ("${widget.name}","$time", "$score","${DateTime.now()}")');
      print("kayıt başarılı");
    }catch(e){
      print(e);
    }
    if(result>0){
      return true;
    }else{
      return false;
    }
  }
  yeniOyun(){
    print("yeni oyun");
    if(widget.level=="1"){
      cardCount = 16;
    }else if(widget.level=="2"){
      cardCount = 36;
    }
    _game.initGame(cardCount);
  }
  var sonuc = "0";
  @override
  Widget build(BuildContext context) {
    if(eslesmesol == eslesmesag){
      sonuc="1";
    }else if (eslesmesol != eslesmesag && duration1.inSeconds == 0){
      sonuc="2";
    }
    return WillPopScope(
        onWillPop: (){
          _onWillPop();
          // Navigator.of(context, rootNavigator: true).pop(context);
        },
        child:Scaffold(
      backgroundColor: Color(0xFFE55870),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              info_card("Hamle", "$tries"),
              info_card("Eşleşme", "${eslesmesol} / ${eslesmesag}"),
              InkWell(
                  onTap: () {
                    // yeniOyun();
                    final isRunning = timer1 == null ? false : timer1.isActive;
                    if (isRunning) {
                      timer1.cancel();
                    }
                    locator<NavigationService>().navigateToUntil(routes.selectRoute);
                  },
                  child:Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: 50,
                      height: 67,
                      child: Center(
                        child: Text("Yeni Oyun",style: TextStyle(),textAlign: TextAlign.center,),
                      )
                  )
              ),
              info_card("Skor", "$score"),
            ],
          ),

          sonuc == "0" ? buildTime1() : Container(),
          sonuc == "0" ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _game.gameImg.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.level =="1" ? 4 : 6,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game.matchCheck);
                        setState(() {
                          //incrementing the clicks
                          tries++;
                          _game.gameImg[index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                          print(_game.matchCheck.first);
                        });
                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            print("true");
                            //incrementing the score
                            setState(() {
                              score += 10;
                              eslesmesol+=1;
                            });
                            if(eslesmesol==eslesmesag){
                              insertUserScore(toplamsure - duration1.inSeconds,score);
                            }

                            _game.matchCheck.clear();
                          } else {
                            print("false");
                            setState(() {
                              score -= 2;
                            });
                            Future.delayed(Duration(milliseconds: 100), () {
                              print(_game.gameColors);
                              setState(() {
                                _game.gameImg[_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg[_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFB46A),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game.gameImg[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  })) : Container(),

          sonuc == "1" ? Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(child: Text("Kazandınız",style: TextStyle(color: Colors.white,fontSize: 20),),),
          ) : Container(),
          sonuc == "2" ? Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(child: Text("Kaybettiniz",style: TextStyle(color: Colors.white,fontSize: 20),),),
          ) : Container(),
        ],
      ),
    ));
  }
}
