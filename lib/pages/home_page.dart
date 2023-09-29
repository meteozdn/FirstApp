import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engquiz/pages/allwords.dart';
import 'package:engquiz/pages/favorites_page.dart';
import 'package:engquiz/pages/kaydetPage.dart';
import 'package:engquiz/pages/my_words.page.dart';
import 'package:engquiz/pages/profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/ana_ekran_button.dart';
import 'kart_cevir.dart';

signUserOut() {
  FirebaseAuth.instance.signOut();
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  final kelimeler = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const myDrawer(),
      appBar: AppBar(
        title: const Text(
          "K-WORDS",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.format_align_left,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: const Color(0xff81a074),
      ),
      backgroundColor: const Color(0xff81a074),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Transform.rotate(
                  angle: 2.4,
                  //origin: const Offset(30, -90),
                  child: Container(
                    margin: const EdgeInsets.only(top: 75),
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [
                          Color(0xff81a074),
                          Color(0xffccd2c9),
                        ],
                      ),
                    ),
                  ),
                ),
                const anasayfaButton()
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const my_bottom_nb(),
    );
  }
}

class my_bottom_nb extends StatelessWidget {
  const my_bottom_nb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: const Color(0x9f798A6B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const profilim()));
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Profil",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const Favoriler()));
                },
                icon: const Icon(
                  Icons.favorite,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Favoriler",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  //Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const arkadaslar()));
                },
                icon: const Icon(
                  Icons.supervised_user_circle_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Arkadaşlar",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class myDrawer extends StatelessWidget {
  const myDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xffbec8b5),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("lib/images/personExm.jpeg"),
                  ),
                  Text(
                    "${FirebaseAuth.instance.currentUser?.displayName} ",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                "Profilim",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const profilim()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.book_rounded,
              ),
              title: const Text(
                "Kelimelerim",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const kelimelerim(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.stairs_outlined),
              title: const Text(
                "İstatistiklerim",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.bar_chart_outlined,
              ),
              title: const Text(
                "Sıralama",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            const ListTile(
              leading: Icon(
                Icons.logout_outlined,
              ),
              title: Text(
                "Çıkış Yap",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: signUserOut,
            ),
          ],
        ),
      ),
    );
  }
}

class anasayfaButton extends StatelessWidget {
  const anasayfaButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: const Text(
              "WW Words",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const Text(
                  "Welcome ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser?.displayName} ",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnaEkranButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const allWords()));
                      },
                      imagePath: "lib/images/book.png",
                      text: "Tüm Kelimeler",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AnaEkranButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const kartlar()));
                      },
                      imagePath: "lib/images/spin.png",
                      text: "Kartlar",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnaEkranButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => kelimeKaydet()));
                      },
                      imagePath: "lib/images/save.png",
                      text: "Kelime Ekle",
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    AnaEkranButton(
                      onTap: () {},
                      imagePath: "lib/images/leaders.png",
                      text: "Sıralama",
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
