import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/configs.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

Widget QuantityRow(double width,double padding){
  return Row(
    children: [
      GestureDetector(
        //to be continued (add action)
      child: Container(
          width: AppDimensions.normalize(width),
          color: AppColors.CommonCyan,
          child: Center(
            child: SvgPicture.asset(AppAssets.Minus,
                color: Colors.white, height: 3),
          ),
        ),
      ),
      Container(
        padding: Space.hf(padding),
        color: Colors.white,
        child: Center(
          child: Text(
            "1",
            style: AppText.h3b,
          ),
        ),
      ),
      GestureDetector(
        //to be continued (add action)
      child: Container(
          width: AppDimensions.normalize(width),
          color: AppColors.CommonCyan,
          child: Center(
            child: SvgPicture.asset(AppAssets.Plus,
                color: Colors.white, height: 13),
          ),
        ),
      )
    ],
  );
}