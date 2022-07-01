import 'package:flutter/material.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_unknown_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CardBarcodeLinkWidget extends CardBarcodeUnknownWidget {
  CardBarcodeLinkWidget({
    Key? key,
    required Barcode barcode,
    required Function(Barcode barcode) onDelete,
  }) : super(
          key: key,
          title: "Link",
          barcode: barcode,
          icon: Icons.link,
          onDelete: onDelete,
          trailing: IconButton(
            onPressed: () async {
              if (await canLaunchUrlString(barcode.value)) {
                await launchUrlString(barcode.value);
              } else {
                throw 'Could not launch ${barcode.value}';
              }
            },
            icon: const Icon(Icons.open_in_new),
          ),
        );
}
