import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../design/buttons_design.dart';
import '../../design/color.dart';


Widget lightBlueBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      child: MaterialButton(
        onPressed: onPressed,
        shape: const StadiumBorder(),
        color: CustomColors.lightBlueColor,
        child: ButtonsDesign.buttonsText(txt, CustomColors.primaryWhiteColor, 15),
      ));
}

Widget lightBlueUnFillBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,

      margin: edgeInsetsGeometry,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: CustomColors.lightBlueColor, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 50),
          child: ButtonsDesign.buttonsText(txt,CustomColors. lightBlueColor, 16),
        ),
      ));
}

Widget purpleBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      child: MaterialButton(
        onPressed: onPressed,
        shape: const StadiumBorder(),
        color: CustomColors.lightPurpleColor,
        child: ButtonsDesign.buttonsText(txt,CustomColors. primaryWhiteColor, 15),
      ));
}
