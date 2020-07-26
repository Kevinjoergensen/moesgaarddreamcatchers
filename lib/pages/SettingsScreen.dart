
import 'package:Moesgaard_Dreamcatchers/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  State createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  _SettingsScreenState();



  @override
  initState() {
    getUserName();
  }

  Future getUserDetails() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: <Widget>[
                          Center(child: Container(
                      padding: EdgeInsets.all(100), 
                        margin: EdgeInsets.all(30),
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data.photoUrl),                                
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 5.0, color: Colors.black)
                            ]))),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "Navn",
                                    textScaleFactor: 1.5,
                                  ),
                                ),
                                Center(
                                  child: Text(snapshot.data.displayName),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(children: <Widget>[
                              Center(
                                child: Text(
                                  "Email",
                                  textScaleFactor: 1.5,
                                ),
                              ),
                              Center(
                                child: Text(snapshot.data.email),
                              ),
                            ],),
                          ),
                          Padding(padding: EdgeInsets.all(10),
                          child: RaisedButton(child: Text("Log Ud"), onPressed: () => _logOut()),),
                          Align(child: FlatButton(onPressed: () => _showDialog(), child: Text("Slet konto",style: TextStyle(color: Colors.red.withOpacity(1.0)))),
                        alignment: Alignment.bottomCenter)
                        ],
                     
                  
                    );
                  
                
              } else {
                return CircularProgressIndicator();
              }
            }
            ),);
  }

  Future getUserName() async {
    String username;
    FirebaseUser user = await FirebaseAuth.instance.currentUser().then((user) {
      username = user.displayName;
    });
    return username;
  }

  void _logOut() async {
    Auth.signOut();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Slet konto"),
          content: new Text("Dette sletter dine personlige oplysninger, din konto og dine fund. Er du sikker på at du vil slette din konto?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Slet konto"),
              onPressed: () {
                Auth.deleteUser();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Annuller"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}
