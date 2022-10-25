import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shifa_app_flutter/design/color.dart';




basicAppBar(txt) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: CustomColors.primaryWhiteColor,
    shape: Border(bottom: BorderSide(color:CustomColors. lightBlueColor, width: 1)),
    title: Text(
      txt,
      style: TextStyle(fontWeight: FontWeight.bold, color:CustomColors. primaryBlackColor),
    ),
  );
}


basicAppBarWithBck(txt) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor:CustomColors. primaryWhiteColor,
    shape: Border(bottom: BorderSide(color: CustomColors.lightBlueColor, width: 1)),
    title: Text(
      txt,
      style: TextStyle(fontWeight: FontWeight.bold, color: CustomColors.primaryBlackColor),
    ),
  );
}

basicAppBarWithMenu(txt,menu,onSelected) {
  return AppBar(
    actions: [

      PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
          itemBuilder:menu,
          onSelected:onSelected
      ),
    ],
    backgroundColor:CustomColors. primaryWhiteColor,
    shape: Border(bottom: BorderSide(color: CustomColors.lightBlueColor, width: 1)),
    title: Text(
      txt,
      style: TextStyle(fontWeight: FontWeight.bold, color: CustomColors.primaryBlackColor),
    ),
  );
}
