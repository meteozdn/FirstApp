import 'package:engquiz/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class profilim extends StatefulWidget {
  const profilim({super.key});

  @override
  State<profilim> createState() => _profilimState();
}

class _profilimState extends State<profilim> {
  final usernameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PROFİL",
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
                setState(() {
                  Navigator.pop(context);
                });
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: const Color(0xff81a074),
      ),
      backgroundColor: const Color(0xff81a074),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("lib/images/personExm.jpeg"),
                backgroundColor: Color(0xff81a074),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                user.displayName.toString().toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Değiştir",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              MyTextField(
                controller: usernameController,
                hintTex: "Kullanıcı Adı",
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              My_Button(
                onTap: () async {
                  if (usernameController.text != "") {
                    await FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(usernameController.text);
                    usernameController.text = "";
                  }
                },
                text: "Kaydet",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
