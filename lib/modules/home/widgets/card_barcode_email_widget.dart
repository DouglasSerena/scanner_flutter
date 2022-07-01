import 'package:flutter/material.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_unknown_widget.dart';
import 'package:share_plus/share_plus.dart';

class CardBarcodeEmailWidget extends CardBarcodeUnknownWidget {
  CardBarcodeEmailWidget({
    Key? key,
    required Barcode barcode,
    required Function(Barcode barcode) onDelete,
  }) : super(
          key: key,
          title: "Email",
          barcode: barcode,
          icon: Icons.email,
          onDelete: onDelete,
          trailing: IconButton(
            onPressed: () async {
              Share.share(barcode.value);
            },
            icon: const Icon(Icons.share),
          ),
        );
}
