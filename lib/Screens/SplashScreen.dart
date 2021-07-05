import 'dart:async';
import 'package:centic_bids/Controllers/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth/Login.dart';
import 'Main/Home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              child: Container(
                child: Text(
                  'CenticBids',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "PoweredBy Achintha",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void startApp() async {
    // await AuthService().checkAuth().then((value) {
      _timer = Timer.periodic(Duration(seconds: 3), (t) {
        if (FirebaseAuth.instance.currentUser != null){
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (_) => Home()),
        );
        } else {
          Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (_) => Login()),
        );
        }
      });
    // });
  }
}
