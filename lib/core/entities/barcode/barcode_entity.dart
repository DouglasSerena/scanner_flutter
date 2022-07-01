import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';

class Barcode {
  final dynamic id;
  final String value;
  final BarcodeType type;

  Barcode({this.id, required this.value, required this.type});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "value": value,
      "type": type.index,
    };
  }

  factory Barcode.create({
    dynamic id,
    required String value,
    required BarcodeType type,
  }) {
    return Barcode(id: id, value: value, type: type);
  }
  factory Barcode.fromJson(Map<String, dynamic> json) {
    return Barcode.create(
      id: json['id'],
      value: json['value'],
      type: BarcodeType.values[json['type']],
    );
  }
}
