import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/kelime_model.dart';
import 'favorites_page.dart';

class kelimelerim extends StatefulWidget {
  const kelimelerim({
    super.key,
  });

  @override
  State<kelimelerim> createState() => _kelimelerimState();
}

class _kelimelerimState extends State<kelimelerim> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  List<Kelime> kelimeler = [];
  @override
  void initState() {
    getkelimelerim();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getAllWords();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //    Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => const Favoriler()));
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: getkelimelerim,
            icon: const Icon(
              Icons.refresh_outlined,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
        title: const Text(
          "KELİMELERİM",
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
                //değişecek
                return kelimeGetir(kelimeler[kelimeler.length - index - 1]);
              },
            ),
          )
        ],
      ),
    );
  }

  Future getkelimelerim() async {
    // print(user);
    Kelime kelime;
    setState(() {
      db
          .collection("kelimeler")
          .where("kullanici", isEqualTo: user.uid)
          .get()
          .then(
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
