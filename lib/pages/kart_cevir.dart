import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/kelime_model.dart';

class kartlar extends StatefulWidget {
  const kartlar({
    super.key,
  });

  @override
  State<kartlar> createState() => _kartlarState();
}

class _kartlarState extends State<kartlar> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  List<Kelime> kelimeler = [];
  bool dil = true;
  @override
  void initState() {
    getAllWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getAllWords();
    return Scaffold(
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
          "KARTLAR",
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
          const SizedBox(height: 25),
          Expanded(
            child: GridView.builder(
              itemCount: kelimeler.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                //değişecek
                return GestureDetector(
                  onTap: () {
                    //   print(kelimeler.length - index - 1);
                    setState(() {});
                    if (kelimeler[kelimeler.length - index - 1].dilD != null) {
                      //   print(kelimeler[index].eng);
                      kelimeler[kelimeler.length - index - 1].dilD =
                          !kelimeler[kelimeler.length - index - 1].dilD!;
                      //    print(index);
                    }
                  },
                  child: kelimeGetir(kelimeler[kelimeler.length - index - 1]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future getAllWords() async {
    //print(user.uid);

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

class kelimeGetir extends StatefulWidget {
  final Kelime kelime;
  const kelimeGetir(
    this.kelime, {
    super.key,
  });

  @override
  State<kelimeGetir> createState() => _kelimeGetirState();
}

class _kelimeGetirState extends State<kelimeGetir> {
  @override
  Widget build(BuildContext context) {
    return dilKart();
  }

  Padding dilKart() {
    if (widget.kelime.dilD != null) {
      if (widget.kelime.dilD!) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: const Color(0xffbec8b5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                widget.kelime.eng!.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: const Color(0xff5a7051),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                widget.kelime.tr!.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }
    } else {
      return const Padding(
        padding: EdgeInsets.all(15),
      );
    }
  }
}
