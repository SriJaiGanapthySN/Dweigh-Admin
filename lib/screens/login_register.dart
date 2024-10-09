import 'package:flutter/material.dart';
import 'package:dweighadmin/screens/login_page.dart';
import 'package:dweighadmin/screens/register_page.dart';
import 'package:dweighadmin/widgets/my_button.dart';

class LoginRegister extends StatelessWidget {
  const LoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFD0F8F5),
      body: Container(
        margin: EdgeInsets.only(top: height * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/images/mudra-applogo.png",
                width: width * 0.9,
              ),
            ),
            SizedBox(height: height * 0.08),
            MyButton(
                text: "LOG IN",
                size: 30,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
            SizedBox(height: height * 0.05),
            MyButton(
                text: "SIGN UP",
                size: 30,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                }),
          ],
        ),
      ),
    );
  }
}
