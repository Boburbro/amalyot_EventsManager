import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void WaitWidget(BuildContext ctx){
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
}