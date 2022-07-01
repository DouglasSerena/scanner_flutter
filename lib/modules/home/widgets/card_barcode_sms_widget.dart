import 'package:flutter/material.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_unknown_widget.dart';
import 'package:share_plus/share_plus.dart';

class CardBarcodeSmsWidget extends CardBarcodeUnknownWidget {
  CardBarcodeSmsWidget({
    Key? key,
    required Barcode barcode,
    required Function(Barcode barcode) onDelete,
  }) : super(
          key: key,
          title: "Sms",
          icon: Icons.sms,
          barcode: barcode,
          onDelete: onDelete,
          trailing: IconButton(
            onPressed: () async {
              Share.share(barcode.value);
            },
            icon: const Icon(Icons.share),
          ),
        );
}
