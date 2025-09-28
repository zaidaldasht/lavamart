import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../../core/constants/colors.dart';

Widget BottomNavContainer(String text, void Function()? onPressed) {
  return Container(
    color: AppColors.LightGrey,
    padding: EdgeInsets.only(
        left: AppDimensions.normalize(8),
        right: AppDimensions.normalize(8),
        top: AppDimensions.normalize(5),
        bottom: AppDimensions.normalize(12)),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppText.h3b?.copyWith(color: Colors.white),
      ),
    ),
  );
}
