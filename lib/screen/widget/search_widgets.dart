import 'dart:ui';

import 'package:flutter/material.dart';

import '../../design/color.dart';


noItemDesign(txt){


  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:CustomColors.lightPinkColor
            ),
            child:Image.asset('assets/images/no_search.png'),
          ),
          const SizedBox(height: 15,),

          const SizedBox(height: 5,),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(txt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:CustomColors. darkGrayColor,
                    fontSize: 15,
                  ),),
              )
          ),
          // Image(image: AssetImage('images/green_fruit.png')),
          // Text('${snapshot.error}' ,),
        ],
      ));
}