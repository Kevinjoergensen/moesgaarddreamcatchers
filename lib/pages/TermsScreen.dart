import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
Navigator.of(context).pop();
},
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            ListView(children: <Widget>[
            Container(child: Padding(
              padding:const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                child: Text(
                    "Her står alle vores vilkår og betingelser. Alt sådan noget kedeligt noget som du egenlig ikke gider at læse men som vi bliver nød til at skrive. Hyg dig!",softWrap: true,style: TextStyle(fontSize: 20) ,textWidthBasis: TextWidthBasis.longestLine,),
              ),
            ),],),
            SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){ Navigator.pop(context);},
                  ),
                ),
          ]
      ),
      )
    );
  }
}
