import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../configs/configs.dart';
import '../../core/app_router.dart';
import '../../core/constants/assets.dart';

Widget TopRow({required bool isFromHome, required BuildContext context}) {
  return SizedBox(
    height: AppDimensions.normalize(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          AppAssets.lvmartAppBar,
          width: AppDimensions.normalize(12),
          height: AppDimensions.normalize(15),
          fit: BoxFit.fill,
        ),
        isFromHome
            ? Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRouter.wishlist);
                },
                child: const Icon(Icons.favorite_border)),
            Space.xf(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.search);
              },
              child: const Icon(Icons.search),
            ),
          ],
        )
            : const SizedBox.shrink()
      ],
    ),
  );
}
