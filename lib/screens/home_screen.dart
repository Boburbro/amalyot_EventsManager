import 'package:amalyot_uchun/screens/scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: const Center(child: Text("Body")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner_rounded),
        onPressed: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => const ScannerScreen(),
          ),
        ),
      ),
    );
  }
}
