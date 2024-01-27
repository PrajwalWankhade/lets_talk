import 'package:flutter/material.dart';

const kAppBarTitle = "Let's Talk Hub";

const kSendButtonTextStyle = TextStyle(
  color: Colors.white, // Change text color to white
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.grey), // Set hint text color
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  color: Colors.black,
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

