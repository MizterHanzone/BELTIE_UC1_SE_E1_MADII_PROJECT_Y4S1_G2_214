import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/data/models/category_model.dart';

class GCategoriesController extends GetxController {
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
        print("== categorise == $categories");
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}