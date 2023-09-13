import 'package:chocsarayi/api/getbranch.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:chocsarayi/screens/home/home_screen.dart';
import 'package:chocsarayi/screens/noservice.dart';
import 'package:chocsarayi/screens/splash/splash_screen.dart';
import 'package:chocsarayi/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'db/Database.dart';
import 'db/db.dart';
import 'di_container.dart' as di;
import 'onboarding_provider.dart';
import 'package:chocsarayi/theme/dark_theme.dart';
import 'package:chocsarayi/theme/light_theme.dart';
import 'package:path/path.dart';

String url="https://chocolatesarayi.xyz/public/";
Database database;
String databasesPath ;
String dbpath ;
List<CartModel> cartproducts=[];
Map user;
String bransh="";
String bransh_name='';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String a= await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic("all");
  await di.init();
  databasesPath = await getDatabasesPath();
  dbpath = join(databasesPath, 'komai.db');
  database = await openDatabase(dbpath, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE favorates (id INTEGER PRIMARY KEY,cat_id TEXT,desc TEXT, pid TEXT,  name TEXT, price TEXT, img TEXT)');
      });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // bransh=prefs.getString("branch");
  // bransh="3";
  prefs.setString("token", a);
  print(prefs.get("token"));
  if(bransh==""||bransh==null){
    // var s=await Geolocator.checkPermission();
    // // var e=Geolocator.isLocationServiceEnabled();
    // if(s==LocationPermission.denied||s==LocationPermission.deniedForever) {
    //   Geolocator.requestPermission();
    // }
    //
    Geolocator.requestPermission().then((value) async{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String lat=position.latitude.toString();
      String long=position.longitude.toString();
      String b=await dogetbranch(lat, long);
      if(b=="no"){
        runApp(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
                ChangeNotifierProvider(
                    create: (context) => di.sl<OnBoardingProvider>()),

              ],
              child: MaterialApp(
                title: 'Chocolate Sarayi',
                debugShowCheckedModeBanner: false,
                theme: light,
                home:noservicepage(),
              ),
            )
        );
      }

      else {
        bransh = b;
        // prefs.setString("branch", b);
        user = await DBProvider.db.getClient(1);
        runApp(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
            ChangeNotifierProvider(
                create: (context) => di.sl<OnBoardingProvider>()),

          ],
          child: MyApp(),
        ));
      }
    });

  }
  else {
    user = await DBProvider.db.getClient(1);
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<OnBoardingProvider>()),

      ],
      child: MyApp(),
    ));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chocolate Sarayi',
      debugShowCheckedModeBanner: false,
      theme: light,
      home:SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
