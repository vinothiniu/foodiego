import 'package:get/get.dart';
import 'package:food_app/routes/app_pages.dart';
import 'package:food_app/constants/app_constants.dart';
import 'dart:async';

import 'auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Timer(Duration(milliseconds: AppConstants.SPLASH_ANIMATION_DURATION), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    // Check if user is already logged in
    final authController = Get.find<AuthController>();

    if (authController.isLoggedIn()) {
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}