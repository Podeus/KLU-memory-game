import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/locator.dart';
import 'package:flutter_base/core/services/view/navigation_service.dart';
import 'package:flutter_base/core/constants/route_paths.dart' as routes;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List list = [];
  @override
  void initState() {
    super.initState();
    scoreslist();
  }
  Future<List> scoreslist() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'score_database.db'),
    );
    final db = await database;
    try {
      list = await db.rawQuery('SELECT * FROM game_scores order by score DESC');
      setState((){
        list = list;
      });
      print("yenilendi");
    }catch(e){
      print(e);
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async => false,
        child:Scaffold(
      backgroundColor: Color(0xFFE55870),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Memory Game",
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Container(
            height: 200,
            child: ScoreListView(
              itemCount: list.length > 0 ? list.length :0,
              onListItem: list.length > 0 ? list: [],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          InkWell(
              onTap: () {
                locator<NavigationService>().navigateTo(routes.selectRoute);
              },
              child:Container(
                  width: 200,
                  height: 35,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFFFF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        )
                      ]
                  ),
                  child: Center(
                    child: Text("Başla",style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                  )
              )
          ),
        ],
      ),
    ));
  }
}

class ScoreListView extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final bool scroll;
  final String buttonType;
  final List onListItem;
  final Color textColor;
  final Color backgroundColor;
  final Color buttonColor;
  final Function onClickAction;

  const ScoreListView({Key key,
    this.itemCount,
    this.onListItem,
    this.currentIndex,
    this.scroll,
    this.buttonType,
    this.textColor,
    this.backgroundColor,
    this.buttonColor,
    this.onClickAction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: scroll== false ? NeverScrollableScrollPhysics() : null,
      shrinkWrap: true,
      // scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      padding: new EdgeInsets.all(5.0),
      itemBuilder: (context, index) => buildCard(context, index),
    );
  }
  Widget buildCard(BuildContext context, int index) {
    return Container(
        padding: new EdgeInsets.all(5.0),
        margin: new EdgeInsets.only(top:10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: Color(0xFFFFFFFF),
          border: Border.all(
              color: Colors.white,
              width: 1.0
          ),
        ),
        child: Column(
          children: [
            index ==0 ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  child: Center(
                    child: Text("İsim",style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text("Süre",style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text("Skor",style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ),
              ],
            ) : Container(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  child: Center(
                    child: Text("${onListItem[index]["name"]}"),
                  )
                ),
                Container(
                  width: 75,
                  child: Center(
                    child: Text("${onListItem[index]["time"]} sn"),
                  )
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text("${onListItem[index]["score"]}"),
                  )
                ),
              ],
            ),
            SizedBox(height: 5,),
          ],
        )
    );
  }
  double opacityValue(int index) => isCurrentIndex(index) ? 1 : 0;

  bool isCurrentIndex(int index) => currentIndex == index;
}
