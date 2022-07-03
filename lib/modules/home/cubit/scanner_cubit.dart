import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';
import 'package:scanner_flutter/core/usecase/delete_scanner_usecase.dart';
import 'package:scanner_flutter/core/usecase/find_all_scanner_usecase.dart';
import 'package:scanner_flutter/core/usecase/save_scanner_usecase.dart';
import 'package:scanner_flutter/shared/state_type.dart';

class ScannerCubit extends Cubit<StateType> {
  late final SaveScannerUseCase _saveScannerUseCase;
  late final DeleteScannerUseCase _deleteScannerUseCase;
  late final FindAllScannerUseCase _findAllScannerUseCase;

  ScannerCubit({
    required FindAllScannerUseCase findAllScannerUseCase,
    required DeleteScannerUseCase deleteScannerUseCase,
    required SaveScannerUseCase saveScannerUseCase,
  }) : super(EmptyState()) {
    _saveScannerUseCase = saveScannerUseCase;
    _deleteScannerUseCase = deleteScannerUseCase;
    _findAllScannerUseCase = findAllScannerUseCase;
  }

  Future find({bool loading = false}) async {
    if (loading) {
      emit(LoadingState());
    }

    try {
      List<Barcode> barcodes = (await _findAllScannerUseCase.execute());

      if (barcodes.isEmpty) {
        emit(EmptyState());
      } else {
        emit(SuccessState(barcodes));
      }
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future add(String value, BarcodeType type) async {
    emit(LoadingState());

    try {
      await _saveScannerUseCase.execute(value, type).whenComplete(() => find());
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future delete(Barcode barcode) async {
    emit(LoadingState());

    try {
      await _deleteScannerUseCase.execute(barcode).whenComplete(() => find());
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }
}
