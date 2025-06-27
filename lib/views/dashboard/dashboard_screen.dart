import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/dashboard_controller.dart';
import 'package:food_app/theme/theme_service.dart';
import 'package:food_app/views/dashboard/tabs/home_tab.dart';
import 'package:food_app/views/dashboard/tabs/favorites_tab.dart';
import 'package:food_app/views/dashboard/tabs/profile_tab.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: [
          const HomeTab(),
          const FavoritesTab(),
          ProfileTab(),
        ],
      )),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return const Text('Food Menu');
          case 1:
            return const Text('My Favorites');
          case 2:
            return const Text('My Profile');
          default:
            return const Text('Food App');
        }
      }),
      elevation: 0,
      actions: [
        // Theme toggle button - Using reactive ThemeService
        Obx(() => IconButton(
          icon: Icon(
            ThemeService.to.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round,
          ),
          onPressed: () {
            ThemeService.to.switchTheme();
          },
        )),
        // Notification button
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            Get.snackbar(
              'Notifications',
              'No new notifications',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTabIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.favorite_outline,
              activeIcon: Icons.favorite,
              label: 'Favorites',
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
            ),
          ],
        )),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }
}