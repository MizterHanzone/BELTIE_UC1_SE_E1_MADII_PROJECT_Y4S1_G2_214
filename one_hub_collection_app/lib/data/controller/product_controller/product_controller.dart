import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:one_hub_collection_app/core/constant/url_connection.dart';
import 'package:one_hub_collection_app/data/model/product_model.dart';

class OHProductController extends GetxController {
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  var message = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }


  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse("${portApi}products"));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        if (kDebugMode) print("Response: $result");

        final List categories = result['categories'];
        final List<ProductModel> loadedProducts = [];

        products.value = loadedProducts;
        filteredProducts.value = loadedProducts;
        allProducts.value = List<ProductModel>.from(loadedProducts); // ✅ this line!

        for (var category in categories) {
          final List productsJson = category['products'];
          for (var productJson in productsJson) {
            loadedProducts.add(ProductModel.fromJson(productJson));
          }
        }

        products.value = loadedProducts;
        filteredProducts.value = loadedProducts;
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
      final response = await http.get(Uri.parse('${portApi}products/filter/by/category/$categoryId'));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['products'];
        final List<ProductModel> fetched = ProductModel.listFromJson(data);

        products.value = fetched;
        filteredProducts.value = List.from(fetched);
        // ❌ Do not update allProducts here
        print("Fetched products: ${fetched.length}");
      } else {
        throw Exception("Failed to load products by category");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void resetToAllProducts() {
    products.value = allProducts;
    filteredProducts.value = allProducts;
  }

}
