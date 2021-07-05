import 'package:centic_bids/Screens/SplashScreen.dart';
import 'package:centic_bids/screens/Auth/forgotPw.dart';
import 'package:centic_bids/screens/Auth/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'ChangeNotifiers/FirebaseData.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseData())
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CenticBids',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/forgotPassword': (context) => ForgotPassword(),
          '/signup': (context) => SignUp()
        },
      ),
    );
  }
}
