import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/components/appbar/baseAppbar.dart';
import 'package:flutter_base/core/locator.dart';
import 'package:flutter_base/core/services/view/dialog_service.dart';
import 'package:flutter_base/core/services/view/navigation_service.dart';
import 'package:flutter_base/core/constants/route_paths.dart' as routes;

class SelectView extends StatefulWidget {
  const SelectView({Key key}) : super(key: key);

  @override
  _SelectViewState createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE55870),
      appBar: BaseAppBar(
        title: Text("Seviye Seçimi",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black)),
        // image: Image.network("${mainPath}uploads/mobil_logo2.png",height: 28,),
        appBar: AppBar(),
        backgroundColor:Color(0xffe6e6e6),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_left,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () =>  locator<NavigationService>().navigateTo(routes.homeRoute)
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Seçim Yapınınız",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 45,
            margin: EdgeInsets.only(top:5),
            padding: EdgeInsets.only(
                top: 4,left: 16, right: 16, bottom: 4
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color(0xFFf2f2f2),
                  // Color(0xFFf2f2f2),
                  Color(0xffCCCCCC),
                  Color(0xffCCCCCC),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(50)
              ),
              // color: _currentTheme.secondaryHeaderColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1
                )
              ],
            ),
            child: TextField(
              textAlign: TextAlign.left,
              controller: usernameController,
              onChanged: (text) {
                print("username: $text");
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                // icon: Icon(Icons.person,
                //   color: Color(0xFF26B13C),
                // ),
                // hintStyle: TextStyle(color: _currentTheme.textSelectionHandleColor),
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Kullanıcı Adı',
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          InkWell(
            onTap: () async{
              if(usernameController.text!=""){
                locator<NavigationService>().navigateToUntil(routes.gameRoute,arguments: {"level":"1","name":usernameController.text});
              }else{
                DialogService _dialogService = locator<DialogService>();
                await _dialogService.showDialog(
                    title: "unlem",
                    description: "Önce Kullanıcı adı giriniz",
                    buttonTitle: "Tamam"
                );
              }
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
                child: Text("1.seviye",style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
              )
            )
          ),
          SizedBox(height: 15,),
          InkWell(
              onTap: () async{
                if(usernameController.text!=""){
                  locator<NavigationService>().navigateToUntil(routes.gameRoute,arguments: {"level":"2","name":usernameController.text});
                }else{
                  DialogService _dialogService = locator<DialogService>();
                  await _dialogService.showDialog(
                      title: "unlem",
                      description: "Önce Kullanıcı adı giriniz",
                      buttonTitle: "Tamam"
                  );
                }
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
                    child: Text("2.seviye",style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                  )
              )
          )
        ],
      ),
    );
  }
}
