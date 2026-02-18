import 'package:flutter/material.dart';
import 'package:hello_chat/constants.dart';
import 'package:hello_chat/widgets/bubbleChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_chat/models/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final __controller = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );

  final TextEditingController controller = TextEditingController();

  void _sendMessage() {
    if (controller.text.isNotEmpty) {
      messages.add({
        'message': controller.text,
        'createdAt': DateTime.now(),
        'id': FirebaseAuth.instance.currentUser!.email!,
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = FirebaseAuth.instance.currentUser!.email!;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>,
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              toolbarHeight: 70,
              title: Text(
                "Hello Chat",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: klogoFont,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: __controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? Bubblechat(message: messagesList[index])
                          : Bubblechat_Frind(message: messagesList[index]);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      _sendMessage();
                      __controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Type...",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: kPrimaryColor),
                        onPressed: () {
                          _sendMessage();
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: kPrimaryColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: kPrimaryColor, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              toolbarHeight: 70,
              title: Text(
                "Hello Chat",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: klogoFont,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        }
      },
    );
  }
}
