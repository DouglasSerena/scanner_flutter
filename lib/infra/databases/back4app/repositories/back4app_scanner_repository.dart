import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';
import 'package:scanner_flutter/core/repositories/scanner_repository.dart';
import 'package:scanner_flutter/infra/databases/back4app/back4app_helper.dart';

class Back4appScannerRepository extends IScannerRepository {
  @override
  Future save(Barcode barcode) async {
    ParseObject object = Back4appHelper.getObject("scanners");

    for (final record in barcode.toMap().entries) {
      object.set(record.key, record.value);
    }

    ParseResponse response = await object.save();
  }

  @override
  Future<List<Barcode>> findAll() async {
    ParseResponse response =
        await Back4appHelper.getObject("scanners").getAll();

    List<Barcode> barcodes = [];
    if (response.success && response.results != null) {
      for (ParseObject object in response.results!) {
        barcodes.add(
          Barcode.create(
            id: object.objectId,
            value: object.get("value"),
            type: BarcodeType.values[object.get("type")],
          ),
        );
      }
    }

    return barcodes;
  }

  @override
  Future delete(Barcode barcode) async {
    ParseResponse response =
        await Back4appHelper.getObject("scanners").delete(id: barcode.id);
  }
}
