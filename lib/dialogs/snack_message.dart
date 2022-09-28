import 'package:flutter/material.dart';

import '../design/color.dart';


void showSuccessMessage(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration:const Duration( seconds: 1),
    content: Text(message,style: TextStyle(
      color:  CustomColors.primaryWhiteColor,
    ),),
    backgroundColor: CustomColors.lightBlueColor,
    behavior: SnackBarBehavior.floating,
  ));
}
