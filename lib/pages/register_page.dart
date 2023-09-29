import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import '../services/auth.service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //User SignIn
  void userSignUp() async {
    //Circle animation
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } else {
        // print("asdasdasd");
        Navigator.pop(context);
        showErrorMessage("Şifreler uyuşmuyor!");
      }
      // Navigator.pop(context);
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
                //logo
                const SizedBox(
                  height: 5,
                ),
                Image.asset(
                  "lib/images/kWordsLogo.png",
                  height: 45,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "K-Words",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                //welcomeback
                const SizedBox(height: 15),
                const Text("Kayıt Ol",
                    style: TextStyle(color: Colors.black, fontSize: 40)),
                const SizedBox(
                  height: 40,
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
                  hintTex: "Sifre",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintTex: "Sifreyi Tekrarla",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign up
                My_Button(
                  text: "Üye Ol",
                  onTap: userSignUp,
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
                      //onTap: () => {},
                      onTap: AuthService().signInWithGoogle,
                      imagePath:
                          "lib/images/googleLogo.png"), /*
                  SquareTile(
                      onTap: () => {}, imagePath: "lib/images/appleLogo.png"),*/
                ]),
                const SizedBox(
                  height: 25,
                ),
                //not member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    Text(
                      "Zaten Hesabım Var.",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Giriş Yap",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
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
