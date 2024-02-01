import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/appProvider.dart';
import '/screens/auth.dart';
import '/screens/scanner.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EventsManager"),
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
      body: const Center(child: Text("Welcome")),
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
