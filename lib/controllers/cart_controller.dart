import 'package:get/get.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }
}

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;
  final RxBool isLoading = false.obs;

  List<CartItem> get cartItems => _cartItems;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Add item to cart
  void addToCart(dynamic food) {
    final existingIndex = _cartItems.indexWhere((item) => item.id == food.id);

    if (existingIndex >= 0) {
      // Item already exists, increase quantity
      _cartItems[existingIndex].quantity++;
      _cartItems.refresh();
    } else {
      // Add new item
      _cartItems.add(CartItem(
        id: food.id,
        name: food.name,
        image: food.image,
        price: food.price.toDouble(),
        description: food.description,
      ));
    }

    Get.snackbar(
      'Added to Cart',
      '${food.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  // Remove item from cart
  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    Get.snackbar(
      'Removed from Cart',
      'Item has been removed from your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  // Update quantity
  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemId);
      return;
    }

    final itemIndex = _cartItems.indexWhere((item) => item.id == itemId);
    if (itemIndex >= 0) {
      _cartItems[itemIndex].quantity = newQuantity;
      _cartItems.refresh();
    }
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
  }

  // Generate order summary for QR payment
  Map<String, dynamic> generateOrderSummary() {
    return {
      'items': _cartItems.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'itemCount': itemCount,
      'orderTime': DateTime.now().toIso8601String(),
      'orderId': 'ORDER_${DateTime.now().millisecondsSinceEpoch}',
    };
  }
}