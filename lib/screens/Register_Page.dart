import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat/constants.dart';
import 'package:hello_chat/screens/login_Page.dart';
import 'package:hello_chat/widgets/customFormTextField.dart';
import 'package:hello_chat/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({
    super.key,
    this.username,
    this.phoneNumber,
    this.email,
    this.password,
  });
  String? username;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? username;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;
  String? usernameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

  Function IfPasswordValid = (String password) {
    if (password.length < 6) {
      return "Password must be at least 6 characters long.";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter.";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Password must contain at least one digit.";
    }
    return null;
  };

  Function IfEmailValid = (String email) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return "Please enter a valid email address.";
    }
    return null;
  };

  Function IfPhoneNumberValid = (String phoneNumber) {
    if (!RegExp(r'^\d{11}$').hasMatch(phoneNumber)) {
      return "Please enter a valid 11-digit phone number.";
    }
    return null;
  };

  Function IfUsernameValid = (String username) {
    if (username.isEmpty) {
      return "Username cannot be empty.";
    }
    return null;
  };

  Function ifPasswordConfirmed = (String password, String confirmPassword) {
    if (password != confirmPassword) {
      return "Passwords do not match.";
    }
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
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
                  text: 'Username',
                  onChanged: (value) {
                    username = value;
                  },
                  errorText: usernameError,
                ),

                const SizedBox(height: 10),
                Customtextfield(
                  text: 'Email address',
                  onChanged: (value) {
                    email = value;
                  },
                  errorText: emailError,
                ),
                const SizedBox(height: 10),
                Customtextfield(
                  text: 'phone number',
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  errorText: phoneError,
                ),
                const SizedBox(height: 10),
                Customtextfield(
                  text: 'Create Password',
                  onChanged: (value) {
                    password = value;
                  },
                  errorText: passwordError,
                ),
                const SizedBox(height: 10),
                Customtextfield(
                  text: 'Confirm Password',
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  errorText: confirmPasswordError,
                ),
                const SizedBox(height: 22),
                CustomButton(
                  text: "Sign Up",
                  onTap: () async {
                    print("Sign Up button pressed!"); 
                    checkNoErrors();
                    
                    if (usernameError != null ||
                        emailError != null ||
                        phoneError != null ||
                        passwordError != null ||
                        confirmPasswordError != null) {
                      print("Validation errors found!"); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fix the errors before signing up.",
                          ),
                        ),
                      );
                      return;
                    }
                    
                    print("No validation errors, proceeding with Sign Up..."); 
                    
                    try {
                      print("Creating user with email: $email"); 
                      
                      UserCredential user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );

                      print("User created successfully! UID: ${user.user!.uid}");

                      await user.user!.updateDisplayName(username);
                      print("Display name updated to: $username"); 

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.user!.uid)
                          .set({
                            'username': username,
                            'phoneNumber': phoneNumber,
                          });
                      
                      print("User data saved to Firestore!"); 
                      print("Navigating to chatPage..."); 

                      Navigator.pushNamed(context, "chatPage");
                      
                      print("Navigation completed!"); 
                    } catch (e) {
                      print("Sign Up Error: $e"); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  },
                ),

                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 13, fontFamily: kmainFont),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 13,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: kmainFont,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkNoErrors() {
    return setState(() {
      usernameError = IfUsernameValid(username ?? '');
      emailError = IfEmailValid(email ?? '');
      phoneError = IfPhoneNumberValid(phoneNumber ?? '');
      passwordError = IfPasswordValid(password ?? '');
      confirmPasswordError = ifPasswordConfirmed(
        password ?? '',
        confirmPassword ?? '',
      );
    });
  }
}