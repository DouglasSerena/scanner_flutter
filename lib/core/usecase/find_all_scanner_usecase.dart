import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';

class FindAllScannerUseCase {
  final IScannerRepository repository;

  FindAllScannerUseCase(this.repository);

  Future<List<Barcode>> execute() async {
    List<Barcode> barcodes = await repository.findAll();

    return barcodes;
  }
}
