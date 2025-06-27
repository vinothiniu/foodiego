import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/dashboard_controller.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Obx(
            () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          padding: EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            // Use local state if available, otherwise fall back to controller state
            final isSelected = selectedCategory != null
                ? category == selectedCategory
                : category == controller.selectedCategory.value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
                controller.changeCategory(category);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}