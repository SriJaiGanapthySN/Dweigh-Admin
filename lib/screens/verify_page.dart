import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dweighadmin/screens/home_page.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  int ot = 10;
  late Timer ct;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();
      startTimer();
      timer = Timer.periodic(
        const Duration(seconds: 2),
        (timer) => checkEmailVerified(),
      );
    }
  }

  void startTimer() {
    ot = 60;
    ct = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (ot > 0) {
            ot--;
          } else {
            ct.cancel();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return isEmailVerified
        ? HomePage()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Verify Email',
                style: TextStyle(
                  color: Color(0xFF034C8C),
                ),
              ),
            ),
            backgroundColor: const Color(0xFFD0F8F5),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Please verify your email ${FirebaseAuth.instance.currentUser!.email}',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.03),
                  const Icon(
                    Icons.mail_lock_rounded,
                    size: 60,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't recieve mail?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          ot < 1
                              ? TextButton(
                                  onPressed: () {
                                    startTimer();
                                    sendEmailVerification();
                                  },
                                  child: const Text(
                                    'Resend Code',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 189, 202, 212),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : Text(
                                  ' Resend Code in $ot',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                        ],
                      ),
                    ],
                  ),
                ]));
  }
}
