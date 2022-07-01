import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';

abstract class IScannerRepository {
  Future<List<Barcode>> findAll();
  Future save(Barcode barcode);
  Future delete(Barcode barcode);
}
