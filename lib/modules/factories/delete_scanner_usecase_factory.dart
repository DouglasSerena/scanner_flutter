import 'package:scanner_flutter/core/repositories/scanner_repository.dart';
import 'package:scanner_flutter/core/usecase/delete_scanner_usecase.dart';
import 'package:scanner_flutter/infra/databases/back4app/repositories/back4app_scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/firebase/repositories/firebase_scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/in-memory/repositories/in_memory_scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/sqlite/repositories/sqlite_scanner_repository.dart';
import 'package:scanner_flutter/shared/environment.dart';

DeleteScannerUseCase deleteScannerUseCaseFactory() {
  late IScannerRepository repository;

  switch (Environment.get("DATABASE")) {
    case "FIREBASE":
      repository = FirebaseScannerRepository();
      break;
    case "SQLITE":
      repository = SqliteScannerRepository();
      break;
    case "BACK4APP":
      repository = Back4appScannerRepository();
      break;
    default:
      repository = InMemoryScannerRepository();
  }

  return DeleteScannerUseCase(repository);
}
