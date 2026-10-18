import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String image;
  final int basePrice;
  final int quantity;
  final String size;
  final String milk;
  final String sugar;
  final String ice;
  final List<String> toppings;
  final List<String> syrups;
  final int unitPrice;

  CartItem({
    required this.name,
    required this.image,
    required this.basePrice,
    required this.quantity,
    required this.size,
    required this.milk,
    required this.sugar,
    required this.ice,
    required this.toppings,
    required this.syrups,
    required this.unitPrice,
  });

  int get totalPrice => unitPrice * quantity;
}

class CartStore {
  CartStore._();

  static final ValueNotifier<List<CartItem>> items =
      ValueNotifier<List<CartItem>>([]);

  static int get totalQuantity =>
      items.value.fold(0, (sum, item) => sum + item.quantity);

  static int get totalPrice =>
      items.value.fold(0, (sum, item) => sum + item.totalPrice);

  static void add(CartItem item) {
    items.value = [...items.value, item];
  }
}
