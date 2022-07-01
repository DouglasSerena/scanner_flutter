import 'package:flutter/material.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';

class CardBarcodeUnknownWidget extends StatelessWidget {
  Barcode barcode;

  Widget? trailing;
  IconData icon = Icons.question_mark;
  Function(Barcode barcode) onDelete;
  String title = "Desconhecido";

  CardBarcodeUnknownWidget({
    Key? key,
    String? title,
    this.trailing,
    IconData? icon,
    required this.barcode,
    required this.onDelete,
  }) : super(key: key) {
    this.icon = icon ?? this.icon;
    this.title = title ?? this.title;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, overflow: TextOverflow.ellipsis, maxLines: 2),
        leading: Icon(icon),
        subtitle: Text(
          barcode.value,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Wrap(
          children: [
            trailing ?? const SizedBox.shrink(),
            PopupMenuButton(
              child: const IconButton(
                onPressed: null,
                icon: Icon(Icons.more_vert),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () => onDelete(barcode),
                    child: const ListTile(
                      title: Text("Deletar"),
                      leading: Icon(Icons.delete),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
