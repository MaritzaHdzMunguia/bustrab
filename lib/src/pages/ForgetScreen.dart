import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetScreen extends StatelessWidget {
  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(4, 102, 200, 1),
        title: Text('Recuperar contrasena'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: editController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                child: RaisedButton(
                  color: Color.fromRGBO(4, 102, 200, 1),
                  onPressed: () {
                    resetPassword(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    child: Text(
                      'Recuperar contrasena',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 0.0,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
        msg:
            "Reset password link has sent your mail please use it to change the password.");
    Navigator.pop(context);
  }
}
