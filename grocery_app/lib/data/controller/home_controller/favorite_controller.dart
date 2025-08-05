import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/data/models/favorite_category_model.dart';
import 'package:online_grocery_delivery_app/data/models/favorite_model.dart';

class FavoriteController extends GetxController {

  final storage = GetStorage();
  RxBool isLoading = false.obs;
  var message = ''.obs;
  var favorites = <FavoriteModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    getFavorite();
    fetchFavoriteCategories();
  }

  Future<void> getFavorite() async {
    final token = storage.read('token');
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse("${portApi}favorites"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        message.value = result['message'];

        final List data = result['data'];
        favorites.value = data.map((e) => FavoriteModel.fromJson(e)).toList();

        favoriteProductIds.value =
            favorites.map((f) => f.id).toList(); // Assuming 'id' is productId
      }
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(int productId) {
    return favoriteProductIds.contains(productId);
  }

  final favoriteProductIds = <int>[].obs;
  Future<void> toggleFavorite(int productId) async {
    final token = storage.read('token');
    try {
      final response = await http.post(
        Uri.parse("${portApi}favorites/toggle"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'product_id': productId}),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        Get.snackbar("Success", result['message']);

        if (favoriteProductIds.contains(productId)) {
          // 🔻 Remove from local list
          favoriteProductIds.remove(productId);
          favorites.removeWhere((fav) => fav.id == productId);
          favorites.refresh(); // Notify UI
        } else {
          // 🔺 Add to local list
          favoriteProductIds.add(productId);
          // OPTIONAL: Re-fetch whole list OR just fetch the added product
          await getFavorite();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> searchFavorite(String query) async {
    final token = storage.read('token');

    try {
      final response = await http.get(
        Uri.parse("${portApi}favorites/search?search=${Uri.encodeQueryComponent(query)}"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final List data = result['data'];

        favorites.value = data.map((e) => FavoriteModel.fromJson(e)).toList();

        favoriteProductIds.value = favorites.map((f) => f.id).toList();
      } else {
        if (kDebugMode) {
          print("Search failed: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  RxList<FavoriteCategoryModel> favoriteCategories = <FavoriteCategoryModel>[].obs;
  Future<void> fetchFavoriteCategories() async {
    final token = storage.read('token');
    try {
      final response = await http.get(
        Uri.parse("${portApi}favorite/categories"),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoryData = data['data'];
        final categories = FavoriteCategoryModel.listFromJson(categoryData);

        // Assuming you have an RxList
        favoriteCategories.value = categories;
      } else {
        if (kDebugMode) {
          print("Failed to fetch favorite categories: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching favorite categories: $e");
      }
    }
  }

  var filteredFavorites = <FavoriteModel>[].obs;
  Future<void> filterFavoritesByCategory(int categoryId) async {
    final token = storage.read('token');
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse("${portApi}favorites/filter/by/category/$categoryId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        message.value = result['message'];

        final List data = result['data'];
        filteredFavorites.value = data.map((e) => FavoriteModel.fromJson(e)).toList();
      }
    } catch (e) {
      if (kDebugMode) print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}