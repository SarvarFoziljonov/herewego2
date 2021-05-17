import 'package:flutter/material.dart';
import 'package:herewego2/services/auth_service.dart';
class HomePage extends StatefulWidget {
  static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home Page"),
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
            AuthService.signOutUser(context);
          },
          color: Colors.red,
          child: Text("Logout", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
