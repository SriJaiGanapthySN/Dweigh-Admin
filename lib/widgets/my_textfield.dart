import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    super.key,
    required this.hinttext,
    required this.obscure,
    required this.controller,
    this.type,
    this.focusNode,
  });

  final String hinttext;
  final bool obscure;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(
                0xFF034C8C,
              ),
            ),
            borderRadius: BorderRadius.circular(
              50,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(
                0xFF034C8C,
              ),
            ),
            borderRadius: BorderRadius.circular(
              50.0,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hinttext,
        ),
        obscureText: obscure,
        minLines: 1,
        maxLines: obscure ? 1 : 3,
      ),
    );
  }
}
