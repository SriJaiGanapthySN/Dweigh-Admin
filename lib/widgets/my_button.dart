import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key, required this.text, required this.onTap, required this.size});
  final void Function() onTap;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF034C8C),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(width * 0.02),
        margin: EdgeInsets.symmetric(horizontal: width * 0.165),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: size,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
