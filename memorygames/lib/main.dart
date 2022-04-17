import 'dart:async';
import 'dart:io' show Platform;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_base/core/locator.dart';
import 'package:flutter_base/core/router.dart' as router;
import 'package:flutter_base/core/constants/route_paths.dart' as routes;

import 'package:flutter_base/core/services/view/navigation_service.dart';
import 'package:flutter_base/core/services/view/dialog_service.dart';

import 'package:flutter_base/core/managers/dialog_manager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
// bool USE_FIRESTORE_EMULATOR = false;
import 'package:flutter/services.dart';
class MyHttpoverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=>true;
  }
}
Future<void> main() async {
  HttpOverrides.global=new MyHttpoverrides();
  WidgetsFlutterBinding.ensureInitialized();


  final database = openDatabase(
    join(await getDatabasesPath(), 'score_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE game_scores(id INTEGER PRIMARY KEY, name TEXT, time TEXT, score INTEGER, created_at DATETIME)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  setupLocator();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  // static void setLocale(BuildContext context, Locale newLocale) {
  //   _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
  //   state.setLocale(newLocale);
  // }

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // Locale _locale;
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }
  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) {
  //     setState(() {
  //       this._locale = locale;
  //     });
  //   });
  //   super.didChangeDependencies();
  // }

  // final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  // FirebaseNotifications firebaseNotifications = new FirebaseNotifications();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  // final LoginViewModel _auth = LoginViewModel();
  // final CardViewModel _credit_card = CardViewModel();
  // final ThemeModel _model = ThemeModel();
  // final ThemeManager _model = ThemeManager();
  var subscription;
  // This widget is the root of your application.
  @override
  void initState() {
    // _pushNotificationService.initialise();
    // try {
    //   _auth.loadSettings();
    // } catch (e) {
    //   print("Error Loading Settings: $e");
    // }

    // try {
    //   _model.init();
    // } catch (e) {
    //   print("Error Loading Theme: $e");
    // }
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print("setupFirebase main");
    //   firebaseNotifications.setupFirebase(context);
    // });
    // subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
    //   // Got a new connectivity status!
    //   await isInternet();
    // });


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      debugShowCheckedModeBanner: false,
      builder: (context, child) =>
          Navigator(
            key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => DialogManager(child: child)),
          ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.homeRoute,
    );
  }
}