import 'package:dweighadmin/screens/weigh_scale.dart';
import 'package:dweighadmin/screens/welcome_screen.dart';
import 'package:dweighadmin/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) async {
    //get auth
    final authservice = AuthService();
    //signout
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
      await authservice.signOut();
      //popping it
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: const Color(0xFFAAD7E2),
      child: Column(
        children: [
          const DrawerHeader(
              child: Center(
                  child: Icon(
            Icons.person,
            color: Color(0xFF034C8D),
            size: 64,
          ))),
          const Divider(
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListTile(
              title: const Text(
                "WEIGH BRIDGE",
                style: TextStyle(
                  color: Color(0xFF034C8D),
                ),
              ),
              leading: const Icon(
                Icons.train_sharp,
                color: Color(0xFF034C8D),
              ),
              onTap: () {
                // Navigate to Home Screen
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListTile(
              title: const Text(
                "WEIGHING SCALE",
                style: TextStyle(
                  color: Color(0xFF034C8D),
                ),
              ),
              leading: const Icon(
                Icons.train_sharp,
                color: Color(0xFF034C8D),
              ),
              onTap: () {
                // Navigate to Home Screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WeighScale()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListTile(
              title: const Text(
                "L O G O U T",
                style: TextStyle(
                  color: Color(0xFF034C8D),
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: Color(0xFF034C8D),
              ),
              onTap: () {
                // logout
                logout(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
