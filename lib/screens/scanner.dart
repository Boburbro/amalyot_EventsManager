import 'package:amalyot_uchun/providers/appProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  QRViewController? qrController;

  String result = "";
  var isScanned = false;

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  void getUserInfo(String userId, BuildContext ctx) async {
    var user =
        await Provider.of<AppProvider>(ctx, listen: false).getUser(userId);
    // ignore: use_build_context_synchronously
    showDialog(
      context: ctx,
      builder: (ctx1) => AlertDialog(
        content: Text(
          user.toString(),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx1).pop();
                setState(() {
                  isScanned = false;
                });
              },
              child: const Text("Close")),
        ],
      ),
    );
  }

  void qr(QRViewController controller, BuildContext ctx) {
    qrController = controller;
    controller.scannedDataStream.listen(
      (event) {
        if (event.code!.isNotEmpty && isScanned == false) {
          setState(() {
            isScanned = true;
          });
          getUserInfo(event.code!, ctx);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("QR scanner"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (c) => qr(c, context),
                ),
              )
            ],
          ),
        ));
  }
}
