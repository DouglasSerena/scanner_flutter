import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';

List<Barcode> _barcodesMemory = [
  Barcode.create(id: 1, value: "https://google.com", type: BarcodeType.url),
  Barcode.create(id: 2, value: "douglas@gmail.com", type: BarcodeType.email),
  Barcode.create(id: 3, value: "5551993234701", type: BarcodeType.phone),
  Barcode.create(
      id: 4,
      value:
          "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Adipisci, ullam?",
      type: BarcodeType.text),
  Barcode.create(
      id: 5,
      value:
          "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Adipisci, ullam?",
      type: BarcodeType.sms),
  Barcode.create(
      id: 6,
      value:
          "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Adipisci, ullam?",
      type: BarcodeType.unknown),
];

class InMemoryScannerRepository extends IScannerRepository {
  List<Barcode> barcodes = _barcodesMemory;

  InMemoryScannerRepository();

  @override
  Future<List<Barcode>> findAll() async {
    return [...barcodes];
  }

  @override
  Future save(Barcode barcode) async {
    barcodes.add(barcode);
  }

  @override
  Future delete(Barcode barcode) async {
    barcodes.removeWhere((_barcode) => _barcode.id == barcode.id);
  }
}
