import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/dashboard_controller.dart';
import 'package:food_app/views/dashboard/components/food_card.dart';
import 'package:lottie/lottie.dart';
import 'package:food_app/constants/assets_constants.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      body: Obx(() {
        if (controller.favoriteFoods.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Empty favorites animation
                Lottie.asset(
                  AssetConstants.LOADING_ANIMATION,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: Colors.grey[400],
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'No favorites yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Tap the heart icon on food items to add them to your favorites',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    controller.changeTabIndex(0);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child: Text('Browse Foods'),
                ),
              ],
            ),
          );
        }

        return AnimatedList(
          initialItemCount: controller.favoriteFoods.length,
          padding: EdgeInsets.only(top: 10, bottom: 20),
          itemBuilder: (context, index, animation) {
            final food = controller.favoriteFoods[index];

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Dismissible(
                  key: ValueKey(food.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    controller.toggleFavorite(food.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${food.name} removed from favorites'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            controller.toggleFavorite(food.id);
                          },
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'favorite_${food.id}',
                    child: FoodCard(food: food),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}