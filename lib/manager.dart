import './providers/appProvider.dart';
import './screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth.dart';

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  bool? isAuth = false;
  bool isLoading = false;

  Future<void> setIsAuth(BuildContext ctx) async {
    try {
      await Provider.of<AppProvider>(ctx, listen: false).autoLogIn().onError(
            (error, stackTrace) => showDialog(
              context: ctx,
              builder: (ctx1) {
                return const AlertDialog(
                  title: Text("Error: auto_log_in"),
                );
              },
            ),
          );
      // ignore: use_build_context_synchronously
      isAuth = await Provider.of<AppProvider>(ctx, listen: false).isAuth();
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: ctx,
          builder: (ctx1) {
            return const AlertDialog(
              title: Text("Xatolik yuzverdi!"),
              content: Text("Internetga ulanmaganga o'xshaysiz!"),
            );
          });
    }
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    setIsAuth(context).then((value) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading 
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : isAuth!
            ? const Home()
            : const Auth();
  }
}
