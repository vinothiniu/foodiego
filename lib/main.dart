import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:food_app/routes/app_pages.dart';
import 'package:food_app/theme/app_theme.dart';
import 'package:food_app/theme/theme_service.dart';
import 'package:food_app/controllers/auth_controller.dart';

import 'controllers/cart_controller.dart';
import 'controllers/dashboard_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize controllers
  Get.put(ThemeService());
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(DashboardController(), permanent: true);
    Get.put(CartController(), permanent: true); // Add this line
    return GetMaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeService.to.theme, // Use the reactive theme getter
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}