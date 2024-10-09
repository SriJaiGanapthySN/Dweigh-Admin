import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dweighadmin/screens/verify_page.dart';
import 'package:dweighadmin/screens/welcome_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("loading.."));
          }
          if (snapshot.hasData) {
            return const VerifyEmail();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
