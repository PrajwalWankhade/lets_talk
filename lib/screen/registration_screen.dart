import 'package:flutter/material.dart';
import 'package:lets_talk/screen/chat_screen.dart';
import 'package:lets_talk/utils/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$kAppBarTitle: Signup'),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  // Lottie animation
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Lottie.network(
                        'https://lottie.host/731f1134-4ba5-489a-9187-ae545895d9b0/3Bz6DC3uMH.json',
                      ),
                    ),
                  ),
                  customTextField(
                    icon: Icon(Icons.email),
                      text: 'Enter email',
                      onChanged: (value) {
                        email = value;
                      },
                      isPassword: false,
                  keyboardtype: TextInputType.emailAddress,),
                  SizedBox(
                    height: 8.0,
                  ),
                  customTextField(
                    icon: Icon(Icons.lock),
                      text: 'Enter password',
                      onChanged: (value) {
                        password = value;
                      },
                      isPassword: true,
                  keyboardtype: TextInputType.text,),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(
                                email: email, password: password);

                            if(newUser!=null) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                            }

                            setState(() {
                              showSpinner = false;
                            });
                          }
                          catch(e) {
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
