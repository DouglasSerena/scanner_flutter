import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';

class SaveScannerUseCase {
  final IScannerRepository repository;

  SaveScannerUseCase(this.repository);

  Future execute(String value, BarcodeType type) async {
    Barcode barcode = Barcode.create(value: value, type: type);

    await repository.save(barcode);
  }
}
