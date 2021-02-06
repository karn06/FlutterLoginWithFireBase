import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/create_new_user.dart';
import 'package:flutter_app/pages/forget_password.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = false;

  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => LoginPage(),
    '/forget_password': (context) => ForgetPassWord(),
    '/create_new_user': (context) => CreateNewUser(),
    '/home': (context) => Home(),
  }));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _setVisibility = false;
  var textControllerEmail = TextEditingController();
  var textControllerPassWord = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  bool _showSpinner = false;

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    /* _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animationController.forward();

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.addStatusListener((status) {
      setState(() {});
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _passwordVisibility() {
    setState(() {
      _setVisibility = !_setVisibility;
    });
  }

  void _showToast(String toastText) {
    Toast.show(toastText, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Color(0xFF000000));
  }

  void _checkInputFieldValue() async {
    setState(() {
      _showSpinner = true;
    });
    if (textControllerEmail.text.isEmpty) {
      _showSpinner = false;
      _showToast("Please Enter Email");
      return;
    }

    if (textControllerPassWord.text.isEmpty) {
      _showSpinner = false;
      _showToast("Please enter password");
      return;
    }

    if (!textControllerEmail.text.contains('@') ||
        !textControllerEmail.text.contains('.')) {
      _showSpinner = false;
      _showToast("Invalid email");
      return;
    }

    try {
      final newUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: textControllerEmail.text,
          password: textControllerPassWord.text);

      if (newUser != null) {
        Navigator.pushNamed(context, '/home');
      }

      setState(() {
        _showSpinner = true;
      });
    } catch (e) {
      _showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Hero(
                  tag: 'profile_picture',
                  child: Center(
                      child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('images/profile.jpeg'),
                  )),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: textControllerEmail,
                decoration: InputDecoration(
                    fillColor: Colors.white12,
                    filled: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Icons.email,
                      size: 19.0,
                      color: Colors.black,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 23.0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_setVisibility,
                autocorrect: false,
                controller: textControllerPassWord,
                decoration: InputDecoration(
                    fillColor: Colors.white12,
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _passwordVisibility();
                      },
                      child: _setVisibility
                          ? Icon(
                              Icons.visibility,
                              size: 20.0,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.visibility_off,
                              size: 20.0,
                              color: Colors.black,
                            ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 23.0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forget_password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 15.0,
                            color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              RaisedButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus.unfocus();
                  _checkInputFieldValue();
                },
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.black26)),
                child: const Text('Log In',
                    style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 25.0,
              ),
              Divider(
                height: 100.0,
                thickness: 1.0,
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/create_new_user');
                      });
                    },
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.black26)),
                    child: const Text('Create Account',
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
