import 'package:engquiz/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void userSignIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    }
    // !!HATALI GİRİŞLERR
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff81a074),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "lib/images/kWordsLogo.png",
                  height: 65,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "K-Words",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                //welcomeback
                const SizedBox(height: 20),
                const Text("Giriş Yap",
                    style: TextStyle(color: Colors.black, fontSize: 40)),
                const SizedBox(
                  height: 25,
                ),
                //username tf
                MyTextField(
                  controller: emailController,
                  hintTex: "E-mail",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                //passwort tf
                MyTextField(
                  controller: passwordController,
                  hintTex: "Şifre",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                //forgot password tf
                const SizedBox(
                  height: 10,
                ),
                //sign in
                My_Button(
                  text: "Giriş Yap",
                  onTap: userSignIn,
                ),
                const SizedBox(
                  height: 50,
                ),
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Diğer Yöntemler",
                            style: TextStyle(color: Colors.black)),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //google + apple sign
                const SizedBox(
                  height: 25,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SquareTile(
                      onTap: AuthService().signInWithGoogle,
                      imagePath: "lib/images/googleLogo.png"),
                ]),
                const SizedBox(
                  height: 25,
                ),
                //not member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Üye Degil Misin?",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Üye Ol",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
