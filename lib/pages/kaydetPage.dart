import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'allwords.dart';

class kelimeKaydet extends StatelessWidget {
  kelimeKaydet({super.key});
  final engFieldController = TextEditingController();
  final trFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const allWords()));
              },
              icon: const Icon(
                Icons.book_outlined,
                color: Colors.black,
              ))
        ],
        title: const Text(
          "Kelim'e Ekle",
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "lib/images/save.png",
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  height: 70,
                ),
                MyTextField(
                  controller: engFieldController,
                  hintTex: "English Word",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: trFieldController,
                  hintTex: "Türkçe Kelime",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                My_Button(
                  onTap: kelimeKaydetFunc,
                  text: "Kaydet",
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future kelimeKaydetFunc() async {
    if (engFieldController.text != "" && trFieldController.text != "") {
      FirebaseFirestore.instance.collection("kelimeler").add(
        {
          'eng': engFieldController.text,
          'tr': trFieldController.text,
          'kullanici': FirebaseAuth.instance.currentUser!.uid,
          'dilD': true
        },
      );
      trFieldController.text = "";
      engFieldController.text = "";
    }
  }
}
