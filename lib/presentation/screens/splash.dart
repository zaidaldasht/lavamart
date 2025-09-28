import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../configs/app.dart';
import '../../configs/configs.dart';
import '../../core/app_router.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextScreen() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.ads,
            (route) => false,
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Stack(
              children: [
                Container(
                  height:AppDimensions.normalize(200) ,
                  width: AppDimensions.normalize(100),

                  child: SvgPicture.asset(
                    AppAssets.lvmartIcon,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: AppDimensions.normalize(0),
                  left: AppDimensions.normalize(40),
                  child: const CircularProgressIndicator(
                    color: AppColors.CommonCyan,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
