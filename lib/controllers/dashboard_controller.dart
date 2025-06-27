import 'package:get/get.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/controllers/auth_controller.dart';

class DashboardController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxList<FoodModel> foodList = <FoodModel>[].obs;
  final RxList<FoodModel> favoriteFoods = <FoodModel>[].obs;
  final RxList<String> categories = <String>["All", "Pizza", "Burger", "Sushi", "Pasta", "Salad"].obs;
  final RxString selectedCategory = "All".obs;
  final RxBool isLoading = false.obs;

  final UserModel? user;

  DashboardController() : user = Get.find<AuthController>().currentUser.value;

  @override
  void onInit() {
    super.onInit();
    fetchFoods();
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> fetchFoods() async {
    try {
      isLoading.value = true;

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));

      // Mock data
      final mockFoods = [
        FoodModel(
          id: 1,
          name: "Margherita Pizza",
          description: "Classic pizza with tomato sauce, mozzarella, and basil",
          price: 10.99,
          imageUrl: "https://images.unsplash.com/photo-1513104890138-7c749659a591",
          category: "Pizza",
          rating: 4.5,
        ),
        FoodModel(
          id: 2,
          name: "Pepperoni Pizza",
          description: "Pizza topped with pepperoni slices",
          price: 12.99,
          imageUrl: "https://images.unsplash.com/photo-1534308983496-4fabb1a015ee",
          category: "Pizza",
          rating: 4.2,
        ),
        FoodModel(
          id: 3,
          name: "Classic Burger",
          description: "Juicy beef patty with lettuce, tomato, and special sauce",
          price: 8.99,
          imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
          category: "Burger",
          rating: 4.3,
        ),
        FoodModel(
          id: 4,
          name: "Chicken Burger",
          description: "Grilled chicken patty with avocado and mayo",
          price: 7.99,
          imageUrl: "https://images.unsplash.com/photo-1615297319587-f399e9742e1c",
          category: "Burger",
          rating: 4.0,
        ),
        FoodModel(
          id: 5,
          name: "California Roll",
          description: "Sushi roll with cucumber, avocado and crab meat",
          price: 9.99,
          imageUrl: "https://images.unsplash.com/photo-1579871494447-9811cf80d66c",
          category: "Sushi",
          rating: 4.7,
        ),
        FoodModel(
          id: 6,
          name: "Spaghetti Carbonara",
          description: "Pasta with egg, cheese, and pancetta",
          price: 11.99,
          imageUrl: "https://images.unsplash.com/photo-1546549032-9571cd6b27df",
          category: "Pasta",
          rating: 4.6,
        ),
        FoodModel(
          id: 7,
          name: "Caesar Salad",
          description: "Fresh romaine lettuce with Caesar dressing and croutons",
          price: 6.99,
          imageUrl: "https://images.unsplash.com/photo-1550304943-4f24f54ddde9",
          category: "Salad",
          rating: 4.1,
        ),
      ];

      foodList.value = mockFoods;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load food items: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  List<FoodModel> getFilteredFoods() {
    if (selectedCategory.value == "All") {
      return foodList;
    } else {
      return foodList.where((food) => food.category == selectedCategory.value).toList();
    }
  }

  void toggleFavorite(int foodId) {
    final index = foodList.indexWhere((food) => food.id == foodId);
    if (index != -1) {
      final food = foodList[index];
      final updatedFood = food.copyWith(isFavorite: !food.isFavorite);
      foodList[index] = updatedFood;

      if (updatedFood.isFavorite) {
        favoriteFoods.add(updatedFood);
      } else {
        favoriteFoods.removeWhere((item) => item.id == foodId);
      }

      foodList.refresh();
      favoriteFoods.refresh();
    }
  }
}