import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as MobileScanner;
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';
import 'package:scanner_flutter/core/usecase/delete_scanner_usecase.dart';
import 'package:scanner_flutter/core/usecase/find_all_scanner_usecase.dart';
import 'package:scanner_flutter/core/usecase/save_scanner_usecase.dart';
import 'package:scanner_flutter/modules/factories/delete_scanner_usecase_factory.dart';
import 'package:scanner_flutter/modules/factories/find_all_scanner_usecase_factory.dart';
import 'package:scanner_flutter/modules/factories/save_scanner_usecase_factory.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_email_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_phone_number_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_sms_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_text_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_unknown_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_link_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/qr_overlay_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  List<Barcode> barcodes = [];
  late final SaveScannerUseCase saveScannerUseCase;
  late final DeleteScannerUseCase deleteScannerUseCase;
  late final FindAllScannerUseCase findAllScannerUseCase;

  _HomeScreenState() : super() {
    findAllScannerUseCase = findAllScannerUseCaseFactory();
    deleteScannerUseCase = deleteScannerUseCaseFactory();
    saveScannerUseCase = saveScannerUseCaseFactory();
  }

  @override
  void initState() {
    super.initState();

    onFindAllScanners().whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  Future onFindAllScanners() async {
    List<Barcode> _barcodes = await findAllScannerUseCase.execute();
    setState(() {
      barcodes = _barcodes;
    });
  }

  Future onSaveScanner(String value, BarcodeType type) async {
    try {
      await saveScannerUseCase
          .execute(value, type)
          .whenComplete(onFindAllScanners);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          action: SnackBarAction(
            label: "OK",
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
    }
  }

  Future onDeleteScanner(Barcode barcode) async {
    try {
      await deleteScannerUseCase
          .execute(barcode)
          .whenComplete(onFindAllScanners);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          action: SnackBarAction(
            label: "OK",
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildScanner(),
            const SizedBox(height: 10),
            _buildHistory()
          ],
        ),
      ),
    );
  }

  Widget _buildScanner() {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          MobileScanner.MobileScanner(
            fit: BoxFit.fitWidth,
            allowDuplicates: false,
            onDetect: (barcode, args) {
              if (barcode.rawValue != null) {
                onSaveScanner(
                  barcode.rawValue!,
                  BarcodeType.values[barcode.type.index],
                );
              }
            },
          ),
          const QRScannerOverlayWidget(
            overlayColour: Color.fromRGBO(0, 0, 2, 0.5),
          )
        ],
      ),
    );
  }

  Widget _buildHistory() {
    return Expanded(
      child: Column(
        children: [
          _buildTitle(),
          Builder(
            builder: (context) {
              if (loading) {
                return _buildLoading();
              }
              return _buildList();
            },
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      children: const [
        SizedBox(height: 50),
        CircularProgressIndicator(),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 6, left: 18, right: 18),
      child: const Text(
        "Historio",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 6, left: 16, right: 16, bottom: 16),
        child: Builder(
          builder: (context) {
            if (barcodes.isEmpty) {
              return Column(
                children: const [
                  SizedBox(height: 15),
                  Text(
                    "Scanner alguma coisa para conseguir visualiza-lo aqui.",
                  )
                ],
              );
            }

            return RefreshIndicator(
              onRefresh: onFindAllScanners,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: ListView.builder(
                itemCount: barcodes.length,
                itemBuilder: (context, index) {
                  Barcode barcode = barcodes[index];

                  switch (barcode.type) {
                    case BarcodeType.url:
                      return CardBarcodeLinkWidget(
                          barcode: barcode, onDelete: onDeleteScanner);
                    case BarcodeType.email:
                      return CardBarcodeEmailWidget(
                          barcode: barcode, onDelete: onDeleteScanner);
                    case BarcodeType.sms:
                      return CardBarcodeSmsWidget(
                          barcode: barcode, onDelete: onDeleteScanner);
                    case BarcodeType.phone:
                      return CardBarcodePhoneNumberWidget(
                          barcode: barcode, onDelete: onDeleteScanner);
                    case BarcodeType.text:
                      return CardBarcodeTextWidget(
                          barcode: barcode, onDelete: onDeleteScanner);
                    default:
                      return CardBarcodeUnknownWidget(
                          barcode: barcode, onDelete: onDeleteScanner);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
