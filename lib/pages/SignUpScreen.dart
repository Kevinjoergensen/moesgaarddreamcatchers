import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Moesgaard_Dreamcatchers/pages/Widgets/CustomTextField.dart';
import 'package:Moesgaard_Dreamcatchers/services/Validator.dart';
import 'package:Moesgaard_Dreamcatchers/models/User.dart';
import 'package:Moesgaard_Dreamcatchers/pages/Widgets/CustomFlatButton.dart';
import 'package:Moesgaard_Dreamcatchers/services/Auth.dart';
import 'package:Moesgaard_Dreamcatchers/pages/Widgets/CustomAlertDialog.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullname = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;


  @override
  void initState() {
    super.initState();
      
   
    
    onBackPress = () {
      Navigator.of(context).pop();
    };

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullname,
      hint: "Navn",
      validator: Validator.validateName,
    );
    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adresse",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Adgangskode",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Opret en ny bruger",
                        softWrap: true,
                        textAlign: TextAlign.left,
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
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _nameField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _phoneField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Opret med E-mail",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _signUp(
                              fullname: _fullname.text,
                              email: _email.text,
                              password: _password.text);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                        borderWidth: 0,
                        color: Color.fromRGBO(212, 20, 15, 1.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "ELLER",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Opret med Facebook",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _facebookSignUp(context: context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                        borderWidth: 0,
                        color: Color.fromRGBO(59, 89, 152, 1.0),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                            child: new Text(
                              'Vilkår og betingelser',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () =>
                                Navigator.pushNamed(context, "/terms"))),
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _facebookSignUp({BuildContext context}) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _changeBlackVisible();
      FacebookLogin facebookLogin = new FacebookLogin();
      FacebookLoginResult result =
          await facebookLogin.logIn(['email', 'public_profile']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        Auth.signInWithFacebok(result.accessToken.token).then((uid) {
          Auth.getCurrentFirebaseUser().then((firebaseUser) {
            User user = new User(
              firstName: firebaseUser.displayName,
              userID: firebaseUser.uid,
              email: firebaseUser.email ?? '',
              profilePictureURL: firebaseUser.photoUrl ?? '',
            );
            Auth.addUser(user);
            savePreferencesOnSignup(user);
            onBackPress();
          });
        });
      }
    } catch (e) {
      print("Fejl under oprettelse med Facebook: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: "Oprettelse fejlet",
        content: exception,
        onPressed: _changeBlackVisible,
      );
    }
    _changeBlackVisible();
  }

  void _signUp(
      {String fullname,
      String email,
      String password,
      BuildContext context}) async {
    if (Validator.validateName(fullname) &&
        Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signUp(email, password).then((uID) {
          User user = new User(email: email, userID: uID, firstName: fullname, profilePictureURL: '');
          Auth.addUser(new User(
              userID: uID,
              email: email,
              firstName: fullname,
              profilePictureURL: ''));
            savePreferencesOnSignup(user);
          onBackPress();
        });
      } catch (e) {
        print("Fejl under oprettelse: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Oprettelse mislykkes",
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  Future savePreferencesOnSignup(User user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', user.firstName);
      prefs.setString('email', user.email);
      prefs.setString('uId', user.userID);
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}
