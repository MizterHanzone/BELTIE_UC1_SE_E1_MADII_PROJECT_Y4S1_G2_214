import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'dart:convert';

import 'package:online_grocery_delivery_app/data/models/category_with_product_model.dart';
import 'package:online_grocery_delivery_app/data/models/product_model.dart';

class GProductController extends GetxController {
  var categoryList = <CategoryWithProductModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  var message = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchGroupedProducts();
    super.onInit();
  }

  Future<void> fetchGroupedProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse("${portApi}products"));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        // Store the API message
        message.value = result['message'];

        // Parse and add category list
        final List data = result['data'];
        categoryList.value = data.map((e) => CategoryWithProductModel.fromJson(e)).toList();
      } else {
        message.value = "Failed to load data. Code: ${response.statusCode}";
      }
    } catch (e) {
      message.value = "Something went wrong: $e";
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('${portApi}products/by/category/$categoryId'));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['products'];
        products.value = ProductModel.listFromJson(data);
        filteredProducts.value = products; // Initially all
      } else {
        throw Exception("Failed to load products by category");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((p) =>
      p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  final RxList<ProductModel> searchedProducts = <ProductModel>[].obs;
  Future<void> searchProductsGuest(String query) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("${portApi}products/search?search=$query"),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        searchedProducts.value = ProductModel.listFromJson(data);
      } else {
        throw Exception("Failed to search products");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  // void filterProductsByCategoryName(String categoryName) {
  //   filteredProducts.value = products.where((p) => p.category == categoryName).toList();
  // }

  void filterLocallyBySearch(String query) {
    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products.where((p) =>
      p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.description.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
  }

}
