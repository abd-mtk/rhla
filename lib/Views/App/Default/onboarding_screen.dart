import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rhla/Views/App/Default/login_screen.dart';

import '../../Constants/app constant/onboarding_list.dart';
import '../../Constants/fonts/fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/onboardingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pagesAxis: Axis.vertical,
        isProgress: false,
        bodyPadding: const EdgeInsets.all(10),
        curve: Curves.easeInExpo,
        globalBackgroundColor: Colors.purple,
        pages: onboardingList,
        showSkipButton: true,
        showNextButton: false,
        skip: const Text("تخطي", style: onBoardingbuttonTextStyle),
        done: const Text("بدء", style: onBoardingbuttonTextStyle),
        skipStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        doneStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onDone: () {
          Get.toNamed(LoginScreen.routeName);
        },
      ),
    );
  }
}
