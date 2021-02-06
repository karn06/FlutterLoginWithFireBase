import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateNewUser extends StatefulWidget {
  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  bool _setNewPasswordVisibility = false;
  var _emailTextController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _auth = FirebaseAuth.instance;

  void _newPasswordVisibility() {
    setState(() {
      _setNewPasswordVisibility = !_setNewPasswordVisibility;
    });
  }

  void _toast(String toast) {
    Toast.show(toast, context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void _checkValidity() {
    if (_emailTextController.text.isEmpty) {
      _toast('Please enter email');
      return;
    }

    if (_newPasswordController.text.isEmpty) {
      _toast('Please enter password');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
        backgroundColor: Colors.black26,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailTextController,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 19.0,
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  fillColor: Colors.white12,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0))),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: !_setNewPasswordVisibility,
              controller: _newPasswordController,
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _newPasswordVisibility();
                    },
                    child: _setNewPasswordVisibility
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
                  contentPadding: EdgeInsets.only(left: 25.0),
                  fillColor: Colors.white12,
                  /*    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black)),*/
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0))),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 55.0,
            ),
            RaisedButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus.unfocus();
                setState(() {
                  _checkValidity();
                });

                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _newPasswordController.text);

                try {
                  if (newUser != null) {
                    print(newUser.user);
                    print(newUser.credential);
                    _toast(
                        'Hi, you can now successfully logIn and can start chatting');
                    Navigator.pushNamed(context, '/');
                  }
                } catch (e) {
                  _toast(e.toString());
                }
              },
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              color: Colors.black26,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.black)),
              child: Text('Confirm'),
            )
          ],
        ),
      ),
    );
  }
}
