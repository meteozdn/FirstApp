import 'package:flutter/material.dart';

class arkadaslar extends StatelessWidget {
  const arkadaslar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Arkadaşlar",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: const Color(0xff81a074),
      ),
      backgroundColor: const Color(0xff81a074),
      body: Column(),
    );
  }
}
