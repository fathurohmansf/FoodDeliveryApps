import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color, description ]
    [
      "Beef Burger",
      "14.000",
      "assets/images/burgerbeef.png",
      Colors.green,
      "Burger dibuat dari daging sapi asli",
      1
    ],
    [
      "Double Beef Burger",
      "50.000",
      "assets/images/burgerdoublebeef.png",
      Colors.yellow,
      "Burger dibuat dari daging sapi asli dengan double beef",
      1
    ],
    [
      "Chicken Burger",
      "20.000",
      "assets/images/burgerchicken.png",
      Colors.brown,
      "Burger dibuat dari daging ayam asli dengan selada dan saus",
      1
    ],
    [
      "Cheese Burger",
      "17.000",
      "assets/images/burgercheese.png",
      Colors.blue,
      "Burger dibuat dari daging sapi asli dengan keju yang melimpah",
      1
    ],
    [
      "Fish Burger",
      "25.000",
      "assets/images/burgerfish.png",
      Colors.red,
      "Burger dibuat dari daging ikan\n salmon dengan saos mayones",
      1
    ],
    [
      "Kentang",
      "15.000",
      "assets/images/kentang.png",
      Colors.teal,
      "Kentang krispy original",
      1
    ],
    [
      "Aqua",
      "5.000",
      "assets/images/water.png",
      Colors.orange,
      "Aqua Air Mineral Murni",
      1
    ],
    [
      "Cola-Cola",
      "10.000",
      "assets/images/colacola.png",
      Colors.cyan,
      "Cola-Cola Seger",
      1
    ],
  ];

  // list of cart items with quantity
  final List<List<dynamic>> _cartItems = [];
  //final List<List<String>> _orderHistory = [];
  final List<List<dynamic>> _orderHistory = [];

  get cartItems => _cartItems;
  List<List<dynamic>> get orderHistory => _orderHistory;
  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    final item = List.from(_shopItems[index]);
    final int existingIndex = _findItemIndex(item[0]);

    if (existingIndex != -1) {
      // If the item already exists, increase the quantity
      _cartItems[existingIndex][5]++;
    } else {
      // If the item is not in the cart, add it with quantity 1
      item.add(1); // Quantity is initially set to 1
      _cartItems.add(item);
    }

    notifyListeners();
  }

  // //
  // void adhistoryCart(int index) {
  //   final
  // }
  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems[index][5]--; // Decrease the quantity

    // Remove the item from the cart if the quantity is zero
    if (_cartItems[index][5] == 0) {
      _cartItems.removeAt(index);
    }

    notifyListeners();
  }

  // Untuk Clean di Cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]) * _cartItems[i][5];
    }
    return totalPrice.toStringAsFixed(3);
  }

  // Helper method to find the index of an item in the cart
  int _findItemIndex(String itemName) {
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i][0] == itemName) {
        return i;
      }
    }
    return -1; // Return -1 if not found
  }

//OngoingDelivery
  void ongoingDelivery() {
    _orderHistory.addAll(List.from(_cartItems));
    print('Recorded Orders: $_orderHistory'); // Add this line for debugging
    clearCart();
    notifyListeners();
  }

  // Untuk Clean di OngoingDelivery
  void clearOngoingDelivery() {
    _orderHistory.clear();
    //_cartItems.clear();
    notifyListeners();
  }
}
