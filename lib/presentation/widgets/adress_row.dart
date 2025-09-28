import 'package:flutter/material.dart';
import'../../configs/configs.dart';

Widget AdressRow(String leftText,String rightText ){
  return Column(
    children: [
      Space.yf(.6),
      Row(
        children: [
          Text(
              leftText   ,
              style: AppText.b1b
          ),
          Text(
              rightText,
              style: AppText.b1
          ),
        ],
      ),
    ],
  );
}