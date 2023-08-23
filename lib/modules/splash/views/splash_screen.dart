import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../utils/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState(){
    main();
    super.initState();
  }
  main() async {
    await Future.delayed(const Duration(seconds: 2));
    if(!mounted)return;
    Navigator.pushReplacementNamed(context, Routes.BASE);
  }
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      body: Center(
        child: CircleAvatar(
          radius: 55.r,
          backgroundColor: theme.primaryColorDark,
          child: Image.asset(Constants.logo, width: 67.w, height: 55.h),
        ).animate().fade().slideY(
            duration: 500.ms,
            begin: 1, curve: Curves.easeInSine
        ),
      ),
    );
  }
}
