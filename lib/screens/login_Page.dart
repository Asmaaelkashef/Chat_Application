import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat/constants.dart';
import 'package:hello_chat/screens/Register_Page.dart';
import 'package:hello_chat/widgets/customFormTextField.dart';
import 'package:hello_chat/widgets/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool inAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      progressIndicator: CircularProgressIndicator(color: kPrimaryColor),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    Image.asset('assets/images/logo.png', height: 150),
                    // const SizedBox(height: 60),
                    Container(
                      margin: const EdgeInsets.only(right: 230),
                      height: 45,
                      width: 45,
                      child: Image.asset(
                        'assets/images/little rabbit.png',
                        height: 150,
                      ),
                    ),
                    Customtextfield(
                      text: 'Email address',
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: 12),
                    Customtextfield(
                      text: 'Password',
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 22),
                    CustomButton(
                      text: "Login",
                      onTap: () async {
                        if (!formKey.currentState!.validate()) return;
                        setState(() {
                          inAsyncCall = true;
                        });

                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );

                          Navigator.pushNamed(context, "chatPage");
                        } on FirebaseAuthException catch (e) {
                          String errorMessage;

                          switch (e.code) {
                            case 'invalid-email':
                              errorMessage = 'invald email , please enter a valid email';
                              break;
                            case 'user-disabled':
                              errorMessage = 'invalid user , please contact support';
                              break;
                            case 'invalid-credential':
                              errorMessage =
                                  'invalid email or password';
                              break;
                            case 'too-many-requests':
                              errorMessage =
                                  'too many requests, please try again later';
                              break;
                            default:
                              errorMessage =  'Error: ${e.message}';
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              backgroundColor: const Color.fromARGB(255, 131, 9, 0),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Unexpected error occurred: ${e.toString()}'),
                              backgroundColor: const Color.fromARGB(255, 131, 9, 0),
                            ),
                          );
                        } finally {
                          setState(() {
                            inAsyncCall = false;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 13, fontFamily: "Ubuntu"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "registerPage");
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 13,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
