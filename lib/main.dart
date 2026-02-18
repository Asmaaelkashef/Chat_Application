import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';  
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:hello_chat/screens/Register_Page.dart';
import 'package:hello_chat/screens/chat_page.dart';
import 'package:hello_chat/screens/login_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

//  if (kDebugMode) {
//     try {
//       await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
//     } catch (e) {
//       print('Emulator already in use');
//     }
//   }
  runApp(Chat_Application());
}

class Chat_Application extends StatelessWidget {
  const Chat_Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "loginPage": (context) => LoginPage(),
        "registerPage": (context) => RegisterPage(),
        "chatPage": (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "loginPage",
    );
  }
}