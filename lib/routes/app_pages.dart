import 'package:get/get.dart';
import 'package:food_app/views/splash/splash_screen.dart';
import 'package:food_app/views/auth/login_screen.dart';
import 'package:food_app/views/dashboard/dashboard_screen.dart';
import 'package:food_app/controllers/splash_controller.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/dashboard_controller.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
      transition: Transition.fadeIn,
    ),
  ];
}

abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
}