import 'package:flutter/material.dart';
import 'package:hello_chat/constants.dart';
import 'package:hello_chat/models/messages.dart';
import 'package:intl/intl.dart'; 

class Bubblechat extends StatelessWidget {
  Bubblechat({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('h:mm a').format(message.createdAt);

    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          padding: EdgeInsets.all(13),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: kmainFont,
                ),
              ),
              SizedBox(height: 5),
              Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontFamily: kmainFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bubblechat_Frind extends StatelessWidget {
  Bubblechat_Frind({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('h:mm a').format(message.createdAt);

    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          padding: EdgeInsets.all(13),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 198, 217),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: kmainFont,
                ),
              ),
              SizedBox(height: 5),
              Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontFamily: kmainFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}