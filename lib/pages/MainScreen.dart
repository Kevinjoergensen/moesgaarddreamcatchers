import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Moesgaard_Dreamcatchers/services/Auth.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;
  
  MainScreen({this.firebaseUser});

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.firebaseUser);

  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 0.5,
          leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
          title: Text("Home"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Log Out'),
                onTap: () {
                  _logOut();
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
              ListTile(
                title: Text('Konto'),
                onTap: () {
                Navigator.of(context).pushNamed("/signup");
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ],
          ),
        ),
        body:        
        Text("Hej")

        
          
          
        );
    // stream: FirebaseDatabase.instance
    //     .reference()
    //     .child("dreamcatchers")
    //     .onValue,
    // builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
    //   if (snapshot.hasData) {
    //     Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
    //     map.forEach((dynamic, v) => print(v["name"]));

    //     return GridView.builder(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 3),
    //       itemCount: map.values.toList().length,
    //       padding: EdgeInsets.all(2.0),
    //       itemBuilder: (BuildContext context, int index) {
    //         return Container(
    //           child: Text(map.values.toList()[index]["name"])
    //           );
    //       }
    //     );
    //   } else {
    //     return CircularProgressIndicator();
    //   }
        
    //         })));
    }
  void _logOut() async {
    Auth.signOut();
  }
  

}