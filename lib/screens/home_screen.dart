import 'package:amalyot_uchun/providers/appProvider.dart';
import 'package:amalyot_uchun/screens/auth.dart';
import 'package:amalyot_uchun/screens/scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) {
                Provider.of<AppProvider>(context, listen: false).logOut();
                return const Auth();
              },
            )),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
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
