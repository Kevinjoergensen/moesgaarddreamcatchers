import 'package:flutter/material.dart';
import 'package:Moesgaard_Dreamcatchers/pages/Widgets/CustomFlatButton.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Icon(
              Icons.phone_iphone,
              color: Color.fromRGBO(212, 20, 15, 1.0),
              size: 125.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Moesgaard Dreamcatchers",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(212, 20, 15, 1.0),
                decoration: TextDecoration.none,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Log ind for at begynde at finde drømmefangere.",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "Log Ind",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed("/signin");
              },
              splashColor: Colors.black12,
              borderColor: Color.fromRGBO(212, 20, 15, 1.0),
              borderWidth: 0,
              color: Color.fromRGBO(212, 20, 15, 1.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "Opret Bruger",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.black54,
              onPressed: () {
                Navigator.of(context).pushNamed("/signup");
              },
              splashColor: Colors.black12,
              borderColor: Colors.black12,
              borderWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}