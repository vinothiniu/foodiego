import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/constants/app_constants.dart';
import 'package:food_app/routes/app_pages.dart';
import 'dart:convert';

class AuthController extends GetxController {
  final GetStorage _box = GetStorage();
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    final userJson = _box.read(AppConstants.USER_DATA_KEY);
    if (userJson != null) {
      try {
        currentUser.value = UserModel.fromJson(json.decode(userJson));
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  bool isLoggedIn() {
    return currentUser.value != null &&
        currentUser.value!.token != null &&
        currentUser.value!.token!.isNotEmpty;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      // For demonstration, we're using mock data
      // In a real app, you would make an API call here
      if (email == "vinothiniumaidurai0810@gmail.com" && password == "password") {
        final user = UserModel(
          id: 1,
          name: "Vinothini",
          email: email,
          token: "mock_token_12345",
          avatar: "https://i.pravatar.cc/150?img=1",
        );

        // Save user to storage if remember me is checked
        if (rememberMe.value) {
          _box.write(AppConstants.USER_DATA_KEY, json.encode(user.toJson()));
          _box.write(AppConstants.USER_TOKEN_KEY, user.token);
        }

        currentUser.value = user;
        Get.offAllNamed(Routes.DASHBOARD);
        return true;
      } else {
        Get.snackbar(
          "Error",
          "Invalid email or password",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred during login: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _box.remove(AppConstants.USER_DATA_KEY);
    _box.remove(AppConstants.USER_TOKEN_KEY);
    currentUser.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}