import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/data/models/cart_item_model.dart';

class GCartController extends GetxController {
  final storage = GetStorage();
  var cartItems = <CartItemModel>[].obs;
  var message = ''.obs;
  var isLoading = false.obs;
  var total = 0.0.obs;
  var count = 0.obs;

  final RxInt distinctProductCount = 0.obs;

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    final token = storage.read('token');
    try {
      final response = await http.get(Uri.parse('${portApi}cart/view'),
          headers: {
        'Authorization': 'Bearer $token',
      });

      if (kDebugMode) {
        print("Cart API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List items = json['data']['cart'];

        cartItems.value = items.map((item) => CartItemModel.fromJson(item)).toList();

        // ✅ Add these:
        distinctProductCount.value = cartItems.length;
        count.value = json['data']['count'];
        total.value = double.parse(json['data']['total'].toString());

        if (kDebugMode) {
          print("COUNT ${count.value}");
        }
        if (kDebugMode) {
          print("TOTAL ${total.value}");
        }
      }
      else {
        if (kDebugMode) {
          print('Cart fetch failed: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Cart fetch error: $e");
      }
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    final token = storage.read('token');
    try {
      final response = await http.post(
        Uri.parse("${portApi}cart/add"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'product_id': productId.toString(),
          'quantity': quantity.toString(),
        },
      );

      final result = json.decode(response.body);
      if (kDebugMode) {
        print("AddToCart Response: $result");
      }

      if (response.statusCode == 200 && result['success'] == true) {
        // ✅ Update just that item locally
        final index = cartItems.indexWhere((item) => item.productId == productId);
        if (index != -1) {
          final item = cartItems[index];
          cartItems[index] = CartItemModel(
            id: item.id,
            productId: item.productId,
            name: item.name,
            photo: item.photo,
            quantity: item.quantity + quantity,
            price: item.price,
            currentPrice: item.currentPrice,
            subtotal: (item.quantity + quantity) * item.price,
          );
        } else {
          // Optional: add new item if not exist
          await fetchCart(); // Or better, just insert the item manually
        }

        _recalculateTotal();

        Get.snackbar("Add to Cart", "Product added successfully");
      } else {
        Get.snackbar("Cannot Add to Cart", result['message'] ?? "Error");
      }
    } catch (e) {
      message.value = "Something went wrong: $e";
      Get.snackbar("Error", message.value);
    }
  }

  Future<void> removeCartItem(int productId) async {
    final token = storage.read('token');
    try {
      final response = await http.delete(
        Uri.parse("${portApi}cart/remove/$productId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final result = json.decode(response.body);
      if (response.statusCode == 200 && result['success']) {
        cartItems.removeWhere((item) => item.productId == productId);
        _recalculateTotal();
        Get.snackbar("Success", "Product removed from cart.");
      } else {
        Get.snackbar("Error", result['message'] ?? 'Failed to remove.');
      }
    } catch (e) {
      message.value = "Something went wrong: $e";
    }
  }

  void _recalculateTotal() {
    total.value = cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
    count.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
    distinctProductCount.value = cartItems.length;
  }


  void clearCart() {
    cartItems.clear();
    distinctProductCount.value = 0;
    total.value = 0;
  }

  Future<void> increaseCart(int productId, int quantity) async {
    final token = storage.read('token');
    try {
      final response = await http.post(
        Uri.parse("${portApi}cart/add"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'product_id': productId.toString(),
          'quantity': quantity.toString(),
        },
      );

      final result = json.decode(response.body);
      if (kDebugMode) {
        print("AddToCart Response: $result");
      }

      if (response.statusCode == 200 && result['success'] == true) {
        // ✅ Update just that item locally
        final index = cartItems.indexWhere((item) => item.productId == productId);
        if (index != -1) {
          final item = cartItems[index];
          cartItems[index] = CartItemModel(
            id: item.id,
            productId: item.productId,
            name: item.name,
            photo: item.photo,
            quantity: item.quantity + quantity,
            price: item.price,
            currentPrice: item.currentPrice,
            subtotal: (item.quantity + quantity) * item.price,
          );
        } else {
          // Optional: add new item if not exist
          await fetchCart(); // Or better, just insert the item manually
        }

        _recalculateTotal();

      } else {
        Get.snackbar("Cannot Add to Cart", result['message'] ?? "Error");
      }
    } catch (e) {
      message.value = "Something went wrong: $e";
      Get.snackbar("Error", message.value);
    }
  }

  Future<void> updateCartItemQuantity(int productId, int newQuantity) async {
    final token = storage.read('token');

    // Find CartItem id by productId (assuming you have unique productId per cart item)
    final cartItem = cartItems.firstWhereOrNull((item) => item.productId == productId);

    if (cartItem == null) {
      Get.snackbar("Error", "Cart item not found.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("${portApi}cart/items/${cartItem.id}/update"), // assuming CartItem has 'id' field
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'quantity': newQuantity.toString(),
        },
      );

      final result = json.decode(response.body);
      if (response.statusCode == 200 && result['success'] == true) {
        // Refresh cart after update
        await fetchCart();
      } else {
        Get.snackbar("Error", result['message'] ?? "Failed to update quantity.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      if (kDebugMode) {
        print("Something went wrong: $e");
      }
    }
  }

}