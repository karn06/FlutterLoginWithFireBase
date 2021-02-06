import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ForgetPassWord extends StatefulWidget {
  @override
  _ForgetPassWordState createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  bool _setNewPasswordVisibility = false;
  bool _setReNewPasswordVisibility = false;
  var _emailTextController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _reNewPasswordController = TextEditingController();

  void _newPasswordVisibility() {
    setState(() {
      _setNewPasswordVisibility = !_setNewPasswordVisibility;
    });
  }

  void _reNewPasswordVisibility() {
    setState(() {
      _setReNewPasswordVisibility = !_setReNewPasswordVisibility;
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

    if (_reNewPasswordController.text.isEmpty) {
      _toast('Please re enter password');
      return;
    }

    if (_newPasswordController.text != _reNewPasswordController.text) {
      _toast('Password entered is not same');
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
                  labelText: 'New Password',
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
              obscureText: !_setReNewPasswordVisibility,
              controller: _reNewPasswordController,
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Re-Enter Password',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _reNewPasswordVisibility();
                    },
                    child: _setReNewPasswordVisibility
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
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0))),
            ),
            SizedBox(
              height: 55.0,
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _checkValidity();
                });
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
