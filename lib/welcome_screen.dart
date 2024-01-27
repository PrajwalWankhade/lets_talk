
import 'package:flutter/material.dart';
import 'package:lets_talk/screen/login_screen.dart';
import 'package:lets_talk/screen/registration_screen.dart';
import 'package:lets_talk/utils/customButton.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late double iconSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // Use a light background color
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Lottie.network('https://lottie.host/f9ec5a90-0c4b-4dc6-944f-65c6fb6c7e45/bfyIK1TyG6.json'),
            ),

            Text('Chatify by Prajwal', textAlign: TextAlign.center,),
            SizedBox(
              height: 8,
            ),
            CustomButton(
              text: 'Log In',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            CustomButton(
              text: 'Register',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}