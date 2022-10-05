import 'package:flutter/material.dart';

import '../../design/color.dart';


profileListDesign(txt, image, {onPressed}) {
  return ListTile(
    tileColor:CustomColors. primaryWhiteColor,
    onTap: onPressed,
    leading: Icon(image , color: CustomColors.lightBlueColor,),
    title: Text(
      txt,
      style: TextStyle(
          color:CustomColors. primaryBlackColor, fontSize: 18),
    ),
  );
}


