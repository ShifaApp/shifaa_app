import 'package:flutter/material.dart';

import '../../design/color.dart';


profileListDesign(txt, image, {onPressed, int badge = 0}) {
  return ListTile(
    tileColor:CustomColors. primaryWhiteColor,
    onTap: onPressed,
    leading: Icon(image , color: CustomColors.lightBlueColor,),
    title: Text(
      txt,
      style: TextStyle(
          color:CustomColors. primaryBlackColor, fontSize: 18),
    ),
    trailing: badge != 0
        ? Container(
            decoration: BoxDecoration(
                color:CustomColors. lightGrayBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color:CustomColors. lightGrayColor)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
              child: Text(
                badge.toString(),
                style: TextStyle(color:CustomColors. primaryBlackColor),
              ),
            ),
          )
        : null,
  );
}


