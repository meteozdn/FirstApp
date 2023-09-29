import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnaEkranButton extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String text;
  const AnaEkranButton(
      {super.key,
      required this.onTap,
      required this.imagePath,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 177,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0x9f6B7E60),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
