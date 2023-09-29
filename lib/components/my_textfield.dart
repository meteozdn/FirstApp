import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintTex;
  final bool obscureText;

  const MyTextField(
      {required this.controller,
      required this.hintTex,
      required this.obscureText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                //DIKKAT BORDER ENABLED DURUMDAYKEN !!
                borderSide: BorderSide(color: Color(0xff5a7051))),
            focusedBorder: const OutlineInputBorder(
                //DIKKAT BORDER ENABLED DURUMDAYKEN !!
                borderSide: BorderSide(color: Color(0xff5a7051))),
            fillColor: const Color(0xffabbba0),
            filled: true,
            hintText: hintTex,
            hintStyle: const TextStyle(color: Color(0xff5a7051))),
      ),
    );
  }
}
