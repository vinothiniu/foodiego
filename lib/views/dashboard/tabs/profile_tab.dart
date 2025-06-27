import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/dashboard_controller.dart';
import 'package:food_app/theme/theme_service.dart';
import 'package:food_app/constants/assets_constants.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({Key? key}) : super(key: key);

  final DashboardController dashboardController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildDarkModeSwitch(),
          const SizedBox(height: 16),
          _buildMenuItems(),
          const SizedBox(height: 24),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        final user = controller.user;

        return Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: user?.avatar != null
                    ? NetworkImage(user!.avatar!)
                    : const AssetImage(AssetConstants.AVATAR_PLACEHOLDER) as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? "User",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? "user@example.com",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                // Edit profile action
                Get.snackbar(
                  "Coming Soon",
                  "Edit profile feature coming soon!",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Get.theme.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDarkModeSwitch() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          Get.isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
          color: Get.isDarkMode ? Colors.blueAccent : Colors.orangeAccent,
        ),
        title: const Text(
          "Dark Mode",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Switch(
          value: Get.isDarkMode,
          onChanged: (value) {
            Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            );
          },
          activeColor: Get.theme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifications',
        'subtitle': 'Configure notification settings',
      },
      {
        'icon': Icons.payment_outlined,
        'title': 'Payment Methods',
        'subtitle': 'Manage your payment options',
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Delivery Addresses',
        'subtitle': 'Manage your delivery locations',
      },
      {
        'icon': Icons.help_outline,
        'title': 'Help & Support',
        'subtitle': 'Get help with your orders',
      },
      {
        'icon': Icons.info_outline,
        'title': 'About',
        'subtitle': 'Learn more about Foody App',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(index == 0 ? 12 : 0)
                .copyWith(
                bottomLeft: index == menuItems.length - 1
                    ? const Radius.circular(12)
                    : Radius.zero,
                bottomRight: index == menuItems.length - 1
                    ? const Radius.circular(12)
                    : Radius.zero),
          ),
          child: ListTile(
            leading: Icon(item['icon'] as IconData, color: Get.theme.primaryColor),
            title: Text(item['title'] as String),
            subtitle: Text(item['subtitle'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Get.snackbar(
                "Coming Soon",
                "${item['title']} feature coming soon!",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text("Logout"),
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text("Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    authController.logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Logout"),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}