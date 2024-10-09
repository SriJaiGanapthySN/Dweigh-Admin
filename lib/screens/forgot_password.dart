import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dweighadmin/services/auth/auth_service.dart';
import 'package:dweighadmin/widgets/my_button.dart';
import 'package:dweighadmin/widgets/my_textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  //controller
  final TextEditingController emailcontroller = TextEditingController();

  //reset-password

  void resetPassword(BuildContext context) async {
    final authservice = AuthService();
    try {
      await authservice.forgotPassword(emailcontroller.text);
    } catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Error While  Trying To Reset our Password"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          "Forgot Password",
          style: GoogleFonts.emblemaOne(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF034C8D),
          ),
        ),
        backgroundColor: const Color(0xFFD0F8F5),
      ),
      backgroundColor: const Color(0xFFD0F8F5),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.1),
        child: Column(
          children: [
            Text(
              "Enter your email address to reset your password",
              style: GoogleFonts.lemon(
                fontSize: 18,
                color: const Color(0xFF034C8C),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.02),
            MyTextfield(
                hinttext: "Email", obscure: false, controller: emailcontroller),
            SizedBox(height: height * 0.05),
            MyButton(
                text: "Reset-Password",
                onTap: () => resetPassword(context),
                size: 26)
          ],
        ),
      ),
    );
  }
}
