import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/dashboard_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/views/dashboard/components/category_list.dart';
import 'package:food_app/views/dashboard/components/food_card.dart';
import 'package:food_app/views/cart/cart_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final cartController = Get.put(CartController());

    return RefreshIndicator(
      onRefresh: controller.fetchFoods,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Find Your',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Favorite Food',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Cart Icon with Badge
                        GestureDetector(
                          onTap: () => Get.to(() => CartScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Obx(() {
                                  if (cartController.itemCount > 0) {
                                    return Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Text(
                                          '${cartController.itemCount}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: CategoryList(),
          ),

          // Food Items
          Obx(() {
            final filteredFoods = controller.getFilteredFoods();

            if (controller.isLoading.value) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (filteredFoods.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.no_food,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No food items found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final food = filteredFoods[index];
                  return Hero(
                    tag: 'food_${_getFoodId(food)}',
                    child: FoodCard(
                      food: food,
                      onAddToCart: () => cartController.addToCart(food),
                    ),
                  );
                },
                childCount: filteredFoods.length,
              ),
            );
          }),

          // Bottom Padding
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  // Helper method to safely get food ID
  String _getFoodId(dynamic food) {
    try {
      return food.id?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
    } catch (e) {
      try {
        return food.foodId?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
      } catch (e) {
        return DateTime.now().millisecondsSinceEpoch.toString();
      }
    }
  }
}