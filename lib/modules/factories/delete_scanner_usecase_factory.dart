import 'package:scanner_flutter/core/repositories/scanner_repository.dart';
import 'package:scanner_flutter/core/usecase/delete_scanner_usecase.dart';
import 'package:scanner_flutter/infra/databases/back4app/repositories/back4app_scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/databases.dart';
import 'package:scanner_flutter/infra/databases/firebase/repositories/firebase_scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/in-memory/repositories/in_memory_scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/sqlite/repositories/sqlite_scanner_repository.dart';

DeleteScannerUseCase deleteScannerUseCaseFactory(Databases? database) {
  late IScannerRepository repository;

  switch (database) {
    case Databases.sqlite:
      repository = SqliteScannerRepository();
      break;

    case Databases.back4app:
      repository = Back4appScannerRepository();
      break;

    case Databases.firebase:
      repository = FirebaseScannerRepository();
      break;

    case Databases.inMemory:
    default:
      repository = InMemoryScannerRepository();
  }

  return DeleteScannerUseCase(repository);
}
