import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego2/pages/signin_page.dart';
import 'package:herewego2/services/auth_service.dart';
import 'package:herewego2/services/prefs_service.dart';
import 'package:herewego2/services/utils.dart';

import 'home_page.dart';
class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  _doSignUp () {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String name = nameController.text.toString().trim();
    if (email.isEmpty || password.isEmpty || name.isEmpty) return;
    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser (firebaseUser),
    });
  }

  _getFirebaseUser (FirebaseUser firebaseUser) async{
    if (firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else {
      Utils.fireToast("Check your information");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 45,
              width: double.infinity,
              child: FlatButton(
                onPressed:_doSignUp,
                color: Colors.red,
                child: Text("Sign Up", style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Already have an account?"),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, SignInPage.id);
                  },
                  child: Text("Sign In"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
