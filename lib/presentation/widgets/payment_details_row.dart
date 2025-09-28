import 'package:flutter/material.dart';
import '../../configs/configs.dart';

Widget PaymentDetailsRow(String leftText, String rightText, TextStyle? textStyle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: textStyle ?? AppText.h3,
          ),
          Text(
            "$rightText \$",
            style: textStyle ?? AppText.h3,
          ),
        ],
      ),
      Space.yf(.8)
    ],
  );
}
