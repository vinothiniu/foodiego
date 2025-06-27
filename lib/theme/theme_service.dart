import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxController {
  static ThemeService get to => Get.find();

  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Make this reactive
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode.value = _loadThemeFromBox();
  }

  ThemeMode get theme => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Add this method for backward compatibility
  ThemeMode getThemeMode() => theme;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  void switchTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(_isDarkMode.value);
  }

  void _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  // For backward compatibility
  bool isSavedDarkMode() => _isDarkMode.value;
}