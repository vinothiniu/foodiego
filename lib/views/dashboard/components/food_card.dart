import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final dynamic food;
  final VoidCallback? onAddToCart;

  const FoodCard({
    Key? key,
    required this.food,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: 200,
              width: double.infinity,
              child: _buildFoodImage(),
            ),
          ),

          // Food Details
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getFoodName(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '\$${_getFoodPrice()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                if (_getFoodDescription() != null)
                  Text(
                    _getFoodDescription()!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                SizedBox(height: 16),

                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    String? imageUrl = _getFoodImageUrl();

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Icon(
              Icons.fastfood,
              size: 50,
              color: Colors.grey[600],
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        color: Colors.grey[300],
        child: Icon(
          Icons.fastfood,
          size: 50,
          color: Colors.grey[600],
        ),
      );
    }
  }

  String? _getFoodImageUrl() {
    // Try different possible property names for image
    try {
      if (food.image != null) return food.image;
    } catch (e) {}

    try {
      if (food.imageUrl != null) return food.imageUrl;
    } catch (e) {}

    try {
      if (food.photo != null) return food.photo;
    } catch (e) {}

    try {
      if (food.picture != null) return food.picture;
    } catch (e) {}

    return null;
  }

  String _getFoodName() {
    try {
      return food.name ?? 'Unknown Food';
    } catch (e) {
      try {
        return food.title ?? 'Unknown Food';
      } catch (e) {
        return 'Unknown Food';
      }
    }
  }

  String _getFoodPrice() {
    try {
      if (food.price != null) {
        return food.price.toStringAsFixed(2);
      }
    } catch (e) {}

    try {
      if (food.cost != null) {
        return food.cost.toStringAsFixed(2);
      }
    } catch (e) {}

    return '0.00';
  }

  String? _getFoodDescription() {
    try {
      return food.description;
    } catch (e) {
      try {
        return food.desc;
      } catch (e) {
        try {
          return food.details;
        } catch (e) {
          return null;
        }
      }
    }
  }
}