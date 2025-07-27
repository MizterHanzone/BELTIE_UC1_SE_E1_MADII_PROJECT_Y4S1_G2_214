import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:one_hub_collection_app/core/constant/url_connection.dart';
import 'package:one_hub_collection_app/data/model/category_model.dart';

class OHCategoryController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${portApi}categories'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        categories.value = CategoryModel.listFromJson(data);
        if (kDebugMode) {
          print("== categorise == $categories");
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

}