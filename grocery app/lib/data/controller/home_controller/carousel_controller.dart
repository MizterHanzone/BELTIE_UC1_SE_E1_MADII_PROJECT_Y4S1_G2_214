import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';

class GCarouselController extends GetxController {
  final CarouselSliderController carouselController = CarouselSliderController();
  var currentIndex = 0.obs;
  var photoList = <String>[].obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchPhotosAdvertise();
  }

  Future<void> fetchPhotosAdvertise() async {
    try {
      final response = await http.get(Uri.parse('${portApi}advertisements'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['data'] != null) {
          final List<dynamic> data = jsonData['data'];

          final List<String> photos = data
              .where((item) => item['photo'] != null)
              .map<String>((item) => portPhoto + item['photo'])
              .toList();

          photoList.assignAll(photos);
          print("Advertisement retrieve successfully!");
        } else {
          print('API returned success false or empty data');
        }
      } else {
        print('Failed to fetch. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
