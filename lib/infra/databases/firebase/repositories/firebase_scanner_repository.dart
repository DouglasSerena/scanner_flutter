import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/firebase/firebase_helper.dart';

class FirebaseScannerRepository extends IScannerRepository {
  @override
  Future delete(Barcode barcode) async {
    await FirebaseHelper.firestore.doc("/scanners/${barcode.id}").delete();
  }

  @override
  Future<List<Barcode>> findAll() async {
    QuerySnapshot<Map<String, dynamic>> records =
        await FirebaseHelper.firestore.collection("scanners").get();

    Iterable<Barcode> barcodes = records.docs
        .map((record) => Barcode.fromJson({...record.data(), "id": record.id}));

    return barcodes.toList();
  }

  @override
  Future save(Barcode barcode) async {
    Map<String, dynamic> maps = barcode.toMap();
    maps.remove("id");

    await FirebaseHelper.firestore.collection("scanners").add(maps);
  }
}
