import 'package:flutter/material.dart';
import '../../configs/app.dart';
import '../../configs/configs.dart';
import '../../core/app_router.dart';
import '../../core/constants/assets.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.Ads,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
              bottom: AppDimensions.normalize(10),
              right: AppDimensions.normalize(8),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.root,
                          (route) => false,
                    );
                  },
                  child: Text(
                    "Skip".toUpperCase(),
                    style: AppText.h3b?.copyWith(color: Colors.black),
                  ))),
        ],
      ),
    );
  }
}
