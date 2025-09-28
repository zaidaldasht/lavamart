import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../configs/configs.dart';
import '../../core/app_router.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

PreferredSizeWidget CustomAppBar(
    String title,
    BuildContext context, {
      bool doesHasCartIcon = false,
      bool automaticallyImplyLeading = false,
    }) {
  return PreferredSize(
    preferredSize: Size(double.infinity, AppDimensions.normalize(30)),
    child: Padding(
      padding: EdgeInsets.only(top: AppDimensions.normalize(10)),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(
          title,
          style: AppText.b1b?.copyWith(color: AppColors.GreyText),
        ),
        actions: [
          doesHasCartIcon
              ? GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.cart);
            },
            child: Padding(
              padding: Space.h1!,
              child: SvgPicture.asset(
                AppAssets.Cart,
                color: AppColors.CommonCyan,
              ),
            ),
          )
              : const SizedBox.shrink()
        ],
      ),
    ),
  );
}
