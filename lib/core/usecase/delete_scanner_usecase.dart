import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';

class DeleteScannerUseCase {
  final IScannerRepository repository;

  DeleteScannerUseCase(this.repository);

  Future execute(Barcode barcode) async {
    await repository.delete(barcode);
  }
}
