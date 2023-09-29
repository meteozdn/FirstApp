import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/kelime_model.dart';

class allWords extends StatefulWidget {
  const allWords({
    super.key,
  });

  @override
  State<allWords> createState() => _allWordsState();
}

class _allWordsState extends State<allWords> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  List<Kelime> kelimeler = [];
  @override
  void initState() {
    getAllWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
                      // Navigator.of(context).push(MaterialPageRoute(
                      //    builder: (context) => const profilim()));
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
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: getAllWords,
              icon: const Icon(
                Icons.refresh_outlined,
                color: Colors.black,
                size: 30,
              ))
        ],
        title: const Text(
          "Kelimeler",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: kelimeler.length,
              itemBuilder: (context, index) {
                return kelimeGetir(kelimeler[kelimeler.length - index - 1]);
              },
            ),
          )
        ],
      ),
    );
  }

  Future getAllWords() async {
    Kelime kelime;
    setState(() {
      db.collection("kelimeler").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            docSnapshot.data(); //verilerimiz
            kelime = Kelime.fromFirestore(docSnapshot, null);
            kelimeler.add(kelime);
          }

          setState(() {});
        },
      );
      kelimeler.clear();
    });
  }
}

class kelimeGetir extends StatelessWidget {
  final Kelime kelime;
  const kelimeGetir(
    this.kelime, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 45),
        decoration: BoxDecoration(
          color: const Color(0xff5a7051),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "${kelime.eng}   :   ${kelime.tr}",
            style: const TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
