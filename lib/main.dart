import 'package:Moesgaard_Dreamcatchers/pages/TermsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Moesgaard_Dreamcatchers/pages/MainScreen.dart';
import 'package:Moesgaard_Dreamcatchers/pages/RootScreen.dart';
import 'package:Moesgaard_Dreamcatchers/pages/SignInScreen.dart';
import 'package:Moesgaard_Dreamcatchers/pages/SignUpScreen.dart';
import 'package:Moesgaard_Dreamcatchers/pages/WalkThroughScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moesgaard Dreamcatchers',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
        '/root': (BuildContext context) => new RootScreen(),
        '/signin': (BuildContext context) => new SignInScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/main': (BuildContext context) => new MainScreen(),
        '/terms': (BuildContext context) => new TermsScreen(),
              },
              theme: ThemeData(
                primaryColor: Colors.white,
                primarySwatch: Colors.grey,
              ),
              home: _handleCurrentScreen(),
            );
          }
        
          Widget _handleCurrentScreen() {
            bool seen = (prefs.getBool('seen') ?? false);
            if (seen) {
              return new RootScreen();
            } else {
              return new WalkthroughScreen(prefs: prefs);
            }
          }
        }