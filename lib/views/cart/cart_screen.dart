import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/views/payment/qr_payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            if (cartController.cartItems.isNotEmpty) {
              return TextButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text('Clear Cart'),
                      content: Text('Are you sure you want to remove all items from your cart?'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            cartController.clearCart();
                            Get.back();
                            Get.snackbar(
                              'Cart Cleared',
                              'All items have been removed from your cart',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                            );
                          },
                          child: Text('Clear', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Clear All'),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Add some delicious food to get started!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text('Start Shopping'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return CartItemCard(item: item);
                },
              ),
            ),

            // Bottom Summary and Checkout
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Items:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${cartController.itemCount}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${cartController.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => QRPaymentScreen());
                      },
                      icon: Icon(Icons.qr_code),
                      label: Text('Place Order with QR Payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item; // Use CartItem type for type safety

  const CartItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 80,
              height: 80,
              child: _buildItemImage(),
            ),
          ),

          SizedBox(width: 16),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\${item.price.toStringAsFixed(2)} each',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Total: \${item.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      cartController.updateQuantity(item.id, item.quantity - 1);
                    },
                    icon: Icon(Icons.remove_circle_outline),
                    constraints: BoxConstraints(minWidth: 30, minHeight: 30),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${item.quantity}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cartController.updateQuantity(item.id, item.quantity + 1);
                    },
                    icon: Icon(Icons.add_circle_outline),
                    constraints: BoxConstraints(minWidth: 30, minHeight: 30),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  cartController.removeFromCart(item.id);
                  Get.snackbar(
                    'Item Removed',
                    '${item.name} has been removed from cart',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.withOpacity(0.8),
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                  );
                },
                child: Text(
                  'Remove',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemImage() {
    if (item.image.isNotEmpty) {
      return Image.network(
        item.image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Icon(Icons.fastfood, color: Colors.grey[600]),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    } else {
      return Container(
        color: Colors.grey[300],
        child: Icon(Icons.fastfood, color: Colors.grey[600]),
      );
    }
  }
}