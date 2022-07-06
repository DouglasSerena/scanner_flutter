import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as MobileScanner;
import 'package:scanner_flutter/core/entities/barcode/barcode_entity.dart';
import 'package:scanner_flutter/core/entities/barcode/barcode_type.dart';
import 'package:scanner_flutter/modules/factories/delete_scanner_usecase_factory.dart';
import 'package:scanner_flutter/modules/factories/find_all_scanner_usecase_factory.dart';
import 'package:scanner_flutter/modules/factories/save_scanner_usecase_factory.dart';
import 'package:scanner_flutter/modules/home/cubit/scanner_cubit.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_email_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_phone_number_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_sms_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_text_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_unknown_widget.dart';
import 'package:scanner_flutter/modules/home/widgets/card_barcode_link_widget.dart';
import 'package:scanner_flutter/shared/state_type.dart';
import 'package:scanner_flutter/shared/widgets/icon_theme.widget.dart';
import 'package:scanner_flutter/shared/widgets/qr_overlay_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scannerCubit = ScannerCubit(
    findAllScannerUseCase: findAllScannerUseCaseFactory(),
    deleteScannerUseCase: deleteScannerUseCaseFactory(),
    saveScannerUseCase: saveScannerUseCaseFactory(),
  );

  _HomeScreenState() : super();

  @override
  void initState() {
    super.initState();

    scannerCubit.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner"),
        actions: const [IconButtonThemeWidget()],
      ),
      body: SafeArea(
        child: Stack(
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
                scannerCubit.add(
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
      child: DraggableScrollableSheet(
        minChildSize: 0.45,
        maxChildSize: 0.8,
        initialChildSize: 0.45,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: Container(
                    width: 30,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.overline!.color,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                _buildTitle(),
                _buildContent(scrollController)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 9, left: 18, right: 18),
      child: const Text(
        "Historio",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent(ScrollController scrollController) {
    return BlocBuilder<ScannerCubit, StateType>(
      bloc: scannerCubit,
      builder: (context, state) {
        if (state is SuccessState<List<Barcode>>) {
          return _buildList(state.result, scrollController);
        }

        if (state is ErrorState) {
          return _buildError(state.message);
        }

        if (state is EmptyState) {
          return _buildEmpty();
        }

        return _buildLoading();
      },
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

  Widget _buildEmpty() {
    return Column(
      children: const [
        SizedBox(height: 15),
        Text(
          "Scanner alguma coisa para conseguir visualiza-lo aqui.",
        )
      ],
    );
  }

  Widget _buildList(List<Barcode> barcodes, ScrollController scrollController) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          top: 6,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: RefreshIndicator(
          onRefresh: () => scannerCubit.find(loading: false),
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: ListView.builder(
            itemCount: barcodes.length,
            controller: scrollController,
            itemBuilder: (_, index) {
              Barcode barcode = barcodes[index];

              switch (barcode.type) {
                case BarcodeType.url:
                  return CardBarcodeLinkWidget(
                    barcode: barcode,
                    onDelete: (barcode) => scannerCubit.delete(barcode),
                  );
                case BarcodeType.email:
                  return CardBarcodeEmailWidget(
                    barcode: barcode,
                    onDelete: (barcode) => scannerCubit.delete(barcode),
                  );
                case BarcodeType.sms:
                  return CardBarcodeSmsWidget(
                    barcode: barcode,
                    onDelete: (barcode) => scannerCubit.delete(barcode),
                  );
                case BarcodeType.phone:
                  return CardBarcodePhoneNumberWidget(
                    barcode: barcode,
                    onDelete: (barcode) => scannerCubit.delete(barcode),
                  );
                case BarcodeType.text:
                  return CardBarcodeTextWidget(
                    barcode: barcode,
                    onDelete: (barcode) => scannerCubit.delete(barcode),
                  );
                default:
                  return CardBarcodeUnknownWidget(
                    barcode: barcode,
                    onDelete: (barcode) => scannerCubit.delete(barcode),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Column(
      children: [
        const Text("Houve um error."),
        Text(message),
      ],
    );
  }
}
