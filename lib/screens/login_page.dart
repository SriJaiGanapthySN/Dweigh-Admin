import 'package:flutter/material.dart';
import 'package:dweighadmin/screens/forgot_password.dart';
import 'package:dweighadmin/screens/verify_page.dart';
import 'package:dweighadmin/services/auth/auth_service.dart';
import 'package:dweighadmin/widgets/my_button.dart';
import 'package:dweighadmin/widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  //login method
  void login(BuildContext context) async {
    //auth service
    final authservice = AuthService();

    //login
    try {
      // Show a loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF034C8D),
            ),
          );
        },
      );
      await authservice.signInWithEmailAndPassword(
        emailcontroller.text,
        passwordcontroller.text,
      );

      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const VerifyEmail(),
        ),
        (Route<dynamic> route) => false,
      );
    }
    //error handling
    catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFD0F8F5),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: height * 0.13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/mudra-applogo.png",
                  width: width * 0.75,
                ),
              ),
              SizedBox(height: height * 0.1),
              MyTextfield(
                  hinttext: "Email",
                  obscure: false,
                  controller: emailcontroller),
              SizedBox(height: height * 0.03),
              MyTextfield(
                hinttext: "Password",
                obscure: true,
                controller: passwordcontroller,
              ),
              SizedBox(height: height * 0.05),
              MyButton(text: "LOG IN", onTap: () => login(context), size: 25),
              SizedBox(height: height * 0.05),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: const Divider(
                  endIndent: 2,
                  color: Color(0xFF034C8C),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: const Text(
                    "Forgot your password",
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
