import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/route_constants.dart';
import '../design/color.dart';
import '../helpers/route_helper.dart';



Widget showMessageDialog(
    BuildContext context, String title, String txt, String pageRout) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if (pageRout != noPage)
          directToPageBtns(context, pageRout)
        else
          messageDialogBtns(context),
      ],
    );
  } else {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if (pageRout != noPage)
          directToPageBtns(context, pageRout)
        else
          messageDialogBtns(context),
      ],
    );
  }
}

//------------------------------------
MaterialButton messageDialogBtns(BuildContext context) {
  return MaterialButton(
    textColor:CustomColors. purpleColor,
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text(
      'OK',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
//------------------------------------

MaterialButton directToPageBtns(BuildContext context, String route) {
  return MaterialButton(
    textColor: CustomColors.purpleColor,
    onPressed: () {
      Navigator.pop(context);

      moveToNewStack(context, route);
    },
    child: const Text(
      'OK',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

void showErrorMessageDialog(BuildContext context, String txt) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          showMessageDialog(context, 'Error', txt, noPage));
}
