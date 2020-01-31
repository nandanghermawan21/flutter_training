import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/model/HomeViewModel.dart';
import 'package:pelatihan_dasar_flutter/model/networkModel.dart';
import 'package:pelatihan_dasar_flutter/presenter/DetailPresenter.dart';
import 'package:pelatihan_dasar_flutter/presenter/HomePresenter.dart';
import 'package:pelatihan_dasar_flutter/presenter/LoginPresenter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;
HomeViewModel homeViewModel = new HomeViewModel();
NetworkModel networkModel = new NetworkModel();

class PrefsKey {
  static String user = "user";
}

Future<void> init() async {
  checkInternetConnection();
  prefs = await SharedPreferences.getInstance();
  return;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init().then((onValue) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => homeViewModel,
          ),
          ChangeNotifierProvider(
            create: (context) => networkModel,
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: "login",
      routes: {
        "login": (ctx) => Login(),
        "home": (ctx) => Home(),
        "detail": (ctx) {
          Map<dynamic, dynamic> arg =
              ModalRoute.of(ctx).settings.arguments ?? {};
          return Detail(
            customer: arg["customerData"],
          );
        },
      },
    );
  }
}

void checkInternetConnection() {
  Connectivity().checkConnectivity().then((onValue) {
    print(onValue);
    if (onValue != ConnectivityResult.none) {
      networkModel.networkStatus = true;
      networkModel.commit();
    } else {
      networkModel.networkStatus = false;
      networkModel.commit();
    }
    print(onValue);
  }).catchError((onError) {});
}
