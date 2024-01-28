import 'package:amalyot_uchun/providers/appProvider.dart';
import 'package:amalyot_uchun/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  var isLoading = false;

  void logIn(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    if (username.text.isEmpty || password.text.isEmpty) {
      return;
    }
    Provider.of<AppProvider>(context, listen: false)
        .logIn(username.text, password.text)
        .then((value) {
      Provider.of<AppProvider>(context, listen: false).checkToken().then(
            (value) => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            ),
          );
      setState(() {
        isLoading = false;
      });
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
          // https://www.figma.com/community/file/1088001595404943929/qr-code-scanner-template
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
                    child: const Text("Sign in"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
