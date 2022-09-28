

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design/color.dart';


showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          content:alertContent(context),
        );
      } else {
        return  AlertDialog(
          content:alertContent(context),
        );
      }
    },
  );
}



Widget alertContent(context){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircularProgressIndicator(color: CustomColors.purpleColor,),
      const SizedBox(
        height: 5,
      ),
      const Text('Please Wait',),
    ],
  );
}


Widget loadingProgress(){
  return Center(
      child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: const CircularProgressIndicator()));
}
