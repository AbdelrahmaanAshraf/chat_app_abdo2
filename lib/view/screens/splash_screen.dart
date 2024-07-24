import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app_abdo2/services/local/shared_preference/shared_preference.dart';
import 'package:chat_app_abdo2/view/screens/auth_screens/login_screen.dart';
import 'package:chat_app_abdo2/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xff2B475E),
      splashIconSize: 150.spMax,
      splash: 'assets/images/scholar.png',
      nextScreen: (SharedPreference.read(SharedPreference.isLoginKey) ?? false)
          ? HomeScreen()
          : const LoginScreen(),
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
