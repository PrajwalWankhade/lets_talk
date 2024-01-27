import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Create an instance of Firestore
final _firestore = FirebaseFirestore.instance;

// Declare a variable to store the logged-in user
late User loggedInUser;

// Class for the Chat Screen
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Firebase Authentication instance
  final _auth = FirebaseAuth.instance;

  late String messageText;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Get the current user when the widget is initialized
    getCurrentUser();
  }

  // Function to get the current user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.profile_circled),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              // Sign out and navigate back to the previous screen
              await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('Dump', style: TextStyle(fontFamily: 'Billabong')),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // StreamBuilder to display messages
            MessageStreamBuilder(),
            // Input field and send button
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        // Input field styling
                        decoration: InputDecoration(
                          hintText: 'Type your message here..',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Send button
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Clear text field and send message to Firestore
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying messages using a StreamBuilder
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Extract messages from snapshot
          final messages = snapshot.data?.docs;
          List<customMessageBubble> messageBubbles = [];

          // Iterate through messages and create message bubbles
          for (var message in messages!) {
            final messageText = message['text'] as String;
            final messageSender = message['sender'] as String;
            final currUser = loggedInUser.email;
            final messageBubble = customMessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }

          // Display message bubbles in a ListView
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        } else {
          // Display a loading indicator while waiting for data
          return CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          );
        }
      },
    );
  }
}

// Widget for custom message bubble
class customMessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const customMessageBubble(
      {Key? key, required this.text, required this.sender, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Display sender's name
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          SizedBox(height: 4),
          // Message bubble styling
          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 3.0,
            color: isMe ? Colors.blueAccent : Colors.orangeAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
