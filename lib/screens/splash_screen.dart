import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:takly/constants/app_constant.dart';

import 'sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: EasySplashScreen(
            logo: Image.asset('assets/images/Main_Image/Talky.png'),
            backgroundColor: kPrimaryColor,
            logoWidth: 120,
            navigator: SignInScreen(),
          ),
        ),
      ),
    );
  }
}
