
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _items = {};

  static const String _cartKey = 'paraz_cart';

  Map<int, int> get items => Map.unmodifiable(_items);

  int get totalItems {
    return _items.values.fold(
      0,
      (sum, quantity) => sum + quantity,
    );
  }

  List<Product> get cartProducts {
    return sampleProducts
        .where((product) => _items.containsKey(product.id))
        .toList();
  }

  int quantityOf(int productId) {
    return _items[productId] ?? 0;
  }

  // Load saved cart from local storage.
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCart = prefs.getString(_cartKey);

    if (savedCart != null) {
      try {
        final Map<String, dynamic> decoded =
            jsonDecode(savedCart);

        _items.clear();

        for (final entry in decoded.entries) {
          final id = int.tryParse(entry.key);
          final quantity = entry.value;

          if (id != null &&
              quantity is int &&
              quantity > 0 &&
              sampleProducts.any((p) => p.id == id)) {
            _items[id] = quantity;
          }
        }
      } catch (e) {
        debugPrint('Cart loading error: $e');
      }
    }

    notifyListeners();
  }

  // Save cart to local storage.
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final Map<String, int> data = {};

    _items.forEach((key, value) {
      data[key.toString()] = value;
    });

    await prefs.setString(
      _cartKey,
      jsonEncode(data),
    );
  }

  // Add product.
  Future<void> addToCart(Product product) async {
    _items[product.id] = (_items[product.id] ?? 0) + 1;

    notifyListeners();

    await saveCart();
  }

  // Increase quantity.
  Future<void> increaseQuantity(int productId) async {
    if (!_items.containsKey(productId)) return;

    _items[productId] = _items[productId]! + 1;

    notifyListeners();

    await saveCart();
  }

  // Decrease quantity.
  Future<void> decreaseQuantity(int productId) async {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]! > 1) {
      _items[productId] = _items[productId]! - 1;
    } else {
      _items.remove(productId);
    }

    notifyListeners();

    await saveCart();
  }

  // Remove individual product.
  Future<void> removeItem(int productId) async {
    _items.remove(productId);

    notifyListeners();

    await saveCart();
  }

  // Calculate subtotal.
  double get subtotal {
    double total = 0;

    for (final product in cartProducts) {
      total += product.price * quantityOf(product.id);
    }

    return total;
  }

  // Calculate 10% discount.
  double get discount {
    return subtotal > 2000 ? subtotal * 0.10 : 0;
  }

  // Calculate final total.
  double get finalTotal {
    return subtotal - discount;
  }

  // Clear complete cart.
  Future<void> clearCart() async {
    _items.clear();

    notifyListeners();

    await saveCart();
  }
}
