import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../design/color.dart';

textFieldStyle(
    {context,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    TextEditingController? controller,
    TextInputType? textInputType,
    String? lbTxt,
    obscTxt = false,
      bool enabled = true,readOnly = false,onTap,
    textInputAction}) {
  return Container(
    alignment: Alignment.center,
    margin: edgeInsetsGeometry,
    width: MediaQuery.of(context).size.width / 1.15,
    height: MediaQuery.of(context).size.height / 15,
    decoration: BoxDecoration(
      color:CustomColors. primaryWhiteColor,
      borderRadius: BorderRadius.circular(60),
      border: Border.all(color: CustomColors.lightBlueColor, width: 0.3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(onTap: onTap,
            readOnly: readOnly,
            enabled:enabled ,
            textInputAction: textInputAction,
            obscureText: obscTxt,
            controller: controller,
            keyboardType: textInputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(color: CustomColors.primaryBlackColor),
            decoration: InputDecoration(
              labelText: lbTxt,
              labelStyle: TextStyle(
                color: CustomColors.primaryBlackColor.withOpacity(0.7),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              focusColor: CustomColors.primaryBlackColor,
              border: InputBorder.none,
              counterText: "",
            ),
          ),
        ),
      ],
    ),
  );
}

//-----------------------------------------

searchFieldStyle(
    {context,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    TextEditingController? controller,
    String? initValue,
    onActionClicked}) {
  return Container(
    alignment: Alignment.center,
    margin: edgeInsetsGeometry,
    width: MediaQuery.of(context).size.width / 1.15,
    height: MediaQuery.of(context).size.height / 15,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: CustomColors.primaryWhiteColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(2, 2), // Shadow position
          ),
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              /*   if (fromSearchPage == true) {
                if (controller!.text != '') onActionClicked();
              }*/
            },
            onTap: () {},
            controller: controller,
            maxLines: 1,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
                color: CustomColors.primaryBlackColor, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              labelText: initValue,
              labelStyle: TextStyle(
                  color:CustomColors. primaryBlackColor.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              focusColor:CustomColors. primaryBlackColor,
              border: InputBorder.none,
              counterText: "",
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search,color:CustomColors. darkGrayColor,),
        )
      ],
    ),
  );
}

//-------------------------------


largeTextFieldStyle(
    {context,
      EdgeInsetsGeometry? edgeInsetsGeometry,
      TextEditingController? controller,
      TextInputType? textInputType,
      String? lbTxt,
      obscTxt = false,
      bool enabled = true,
      textInputAction}) {
  return Container(
    alignment: Alignment.center,
    margin: edgeInsetsGeometry,
    width: MediaQuery.of(context).size.width / 1.15,
    height: MediaQuery.of(context).size.height / 8,
    decoration: BoxDecoration(
      color:CustomColors. primaryWhiteColor,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: CustomColors.lightBlueColor, width: 0.3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            enabled:enabled ,
            textInputAction: textInputAction,
            obscureText: obscTxt,
            controller: controller,
            keyboardType: textInputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(color: CustomColors.primaryBlackColor),
            decoration: InputDecoration(
              labelText: lbTxt,
              labelStyle: TextStyle(
                color: CustomColors.primaryBlackColor.withOpacity(0.7),
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              focusColor: CustomColors.primaryBlackColor,
              border: InputBorder.none,
              counterText: "",
            ),
          ),
        ),
      ],
    ),
  );
}
