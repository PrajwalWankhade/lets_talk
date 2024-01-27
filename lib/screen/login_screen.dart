import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk/constants.dart';
import 'package:lets_talk/screen/chat_screen.dart';
import 'package:lets_talk/utils/customButton.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../utils/customTextField.dart';

// Firebase Authentication instance
final _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variables to store email, password, and loading indicator state
  late String email;
  late String password;
  late bool showSpinner = false;

  // Function to handle sign-in functionality on button press
  void _handleSignIn() async {
    setState(() {
      showSpinner = true; // Set loading indicator to true while processing
    });

    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        // Navigate to ChatScreen if sign-in is successful
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          ),
        );
      }

      setState(() {
        showSpinner = false; // Set loading indicator to false after processing
      });
    } catch (e) {
      print(e);
      setState(() {
        showSpinner = false; // Set loading indicator to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$kAppBarTitle: Login'),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner, // Display loading indicator if true
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Lottie.network(
                        'https://lottie.host/45294d09-b712-40f2-975f-1fc7a404798a/2PcrqLN7vh.json',
                      ),
                    ),
                  ),
                  customTextField(
                    icon: Icon(Icons.email),
                    text: 'Enter your email',
                    onChanged: (value) {
                      email = value; // Store entered email
                    },
                    isPassword: false,
                    keyboardtype: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  customTextField(
                    icon: Icon(Icons.lock),
                    text: 'Enter password',
                    onChanged: (value) {
                      password = value; // Store entered password
                    },
                    isPassword: true,
                    keyboardtype: TextInputType.text,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  // Custom button for initiating the sign-in process
                  CustomButton(text: 'Login', onPressed: _handleSignIn),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
