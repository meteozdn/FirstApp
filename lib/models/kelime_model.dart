import 'package:cloud_firestore/cloud_firestore.dart';

class Kelime {
  final String? tr;
  final String? eng;
  final String? kullanici;
  final String? tarih;
  late bool? dilD = true;

  Kelime({
    this.dilD,
    this.tr,
    this.eng,
    this.kullanici,
    this.tarih,
  });

  factory Kelime.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Kelime(
      tr: data?['tr'],
      eng: data?['eng'],
      kullanici: data?['kullanici'],
      dilD: data?['dilD'],
    );
  }
}
