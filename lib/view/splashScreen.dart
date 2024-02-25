import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/view/homeScreen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.to(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/images/splash_pic.jpg",
          fit: BoxFit.cover,
          height: 400.h,
        ),
        20.heightBox,
        Text(
          "Top Headlines News",
          style: GoogleFonts.roboto(
              color: Colors.grey, letterSpacing: 1, fontSize: 18.sp),
        ),
        20.heightBox,
        SpinKitChasingDots(
          color: Colors.blue,
          size: 50.sp,
        )
      ]),
    );
  }
}
