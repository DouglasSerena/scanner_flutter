import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/sqlite/sqlite_helper.dart';

class SqliteScannerRepository extends IScannerRepository {
  @override
  Future save(Barcode barcode) async {
    await SqliteHelper.client.insert("scanners", barcode.toMap());
  }

  @override
  Future<List<Barcode>> findAll() async {
    List<Map<String, Object?>> records =
        await SqliteHelper.client.query("scanners");

    Iterable<Barcode> barcodes =
        records.map((record) => Barcode.fromJson(record));

    return barcodes.toList();
  }

  @override
  Future delete(Barcode barcode) async {
    await SqliteHelper.client
        .delete("scanners", where: "id = ?", whereArgs: [barcode.id]);
  }
}
