import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego2/pages/detail_page.dart';
import 'package:herewego2/pages/home_page.dart';
import 'package:herewego2/pages/signin_page.dart';
import 'package:herewego2/pages/signup_page.dart';
import 'package:herewego2/services/prefs_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
Widget _startPage() {
  return StreamBuilder <FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
       Prefs.saveUserId(snapshot.data.uid);
       return HomePage();
      }else {
        Prefs.removeUserId();
        return SignInPage();
      }
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        DetailPage.id: (context) => DetailPage (),

      },
    );
  }
}

