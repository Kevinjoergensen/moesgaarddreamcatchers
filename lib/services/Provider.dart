
import 'package:Moesgaard_Dreamcatchers/services/Auth.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final Auth auth;
  final db;
  final colors;

  Provider({Key key, Widget child, this.auth, this.db, this.colors}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}