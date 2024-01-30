import 'package:amalyot_uchun/providers/appProvider.dart';
import 'package:amalyot_uchun/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  void logIn(BuildContext ctx) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    if (username.text.isEmpty || password.text.isEmpty) {
      return;
    }

    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx11) => const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CupertinoActivityIndicator(
            radius: 50,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
    );

    Provider.of<AppProvider>(ctx, listen: false)
        .logIn(username.text, password.text)
        .then((value) {
      Navigator.of(context).pop();


      Provider.of<AppProvider>(ctx, listen: false).checkToken().then(
            (value) => Navigator.of(ctx).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => const Home(),
              ),
            ),
          );
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();

      showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: Text(error.toString()),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBar"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                  ),
                  controller: username,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bo'sh qolib ketdi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                  ),
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bo'sh qolib ketdi!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => logIn(context),
                  child: const Text("Sign in"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
