class AppConstants {
  // App Information
  static const String APP_NAME = "Foody";
  static const String APP_VERSION = "1.0.0";

  // Storage Keys
  static const String USER_TOKEN_KEY = "user_token";
  static const String USER_DATA_KEY = "user_data";

  // API Endpoints
  static const String BASE_URL = "https://api.foodapp.com";
  static const String LOGIN_URL = "$BASE_URL/auth/login";
  static const String REGISTER_URL = "$BASE_URL/auth/register";
  static const String FOOD_LIST_URL = "$BASE_URL/foods";

  // Animation Durations
  static const int SPLASH_ANIMATION_DURATION = 1500; // milliseconds
  static const int NORMAL_ANIMATION_DURATION = 300; // milliseconds

}