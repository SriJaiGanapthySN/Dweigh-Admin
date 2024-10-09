import 'package:flutter/material.dart';
import 'package:dweighadmin/screens/login_register.dart';
import 'package:dweighadmin/widgets/my_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFD0F8F5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/mudra-applogo.png",
              width: width * 1,
            ),
          ),
          SizedBox(height: height * 0.05),
          MyButton(
              text: "GET STARTED",
              size: 30,
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LoginRegister()));
              })
        ],
      ),
    );
  }
}
