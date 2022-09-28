import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';

import '../dialogs/progress_dialog.dart';

Widget errorCase(AsyncSnapshot<dynamic?> snapshot) {
  if (snapshot.hasError) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Text('Oops!', style: TextStyle(
        //   color: CustomColors().darkBlueColor,
        //   fontSize: 16,
        //   fontWeight: FontWeight.w700
        // ),),
        const SizedBox(
          height: 5,
        ),
        errorText('${snapshot.error}'),

        // Image(image: AssetImage('images/green_fruit.png')),
        // Text('${snapshot.error}' ,),
      ],
    ));
  } else {
    return loadingProgress();
  }
}

Widget errorCaseInProviderCase(
    AsyncSnapshot<dynamic?> snapshot, Widget widget) {
  if (snapshot.hasError) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Text('Oops!', style: TextStyle(
        //   color: CustomColors().darkBlueColor,
        //   fontSize: 16,
        //   fontWeight: FontWeight.w700
        // ),),
        const SizedBox(
          height: 5,
        ),
        errorText('${snapshot.error}'),

        // Image(image: AssetImage('images/green_fruit.png')),
        // Text('${snapshot.error}' ,),
      ],
    ));
  } else {
    return widget;
  }
}

Widget errorText(String txt) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: CustomColors.lightBlueColor,
        fontSize: 15,
      ),
    ),
  );
}
