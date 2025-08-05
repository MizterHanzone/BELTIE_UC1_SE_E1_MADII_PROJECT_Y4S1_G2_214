import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/data/models/district_model.dart';
import 'package:online_grocery_delivery_app/data/models/province_model.dart';
import 'package:online_grocery_delivery_app/data/models/commune_model.dart';  // Make sure this exists

class GLocation extends GetxController {
  var provinces = <ProvinceModel>[].obs;
  var districts = <DistrictModel>[].obs;
  var communes = <CommuneModel>[].obs;

  final storage = GetStorage();

  String get token => storage.read('token') ?? '';

  Map<String, String> get headers => {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };

  @override
  void onInit() {
    super.onInit();
    fetchProvinces();

    ever<List<ProvinceModel>>(provinces, (newProvinces) {
      if (newProvinces.isNotEmpty) {
        fetchDistricts(provinceId: newProvinces.first.id);
      }
    });

    ever<List<DistrictModel>>(districts, (newDistricts) {
      if (newDistricts.isNotEmpty) {
        fetchCommunes(districtId: newDistricts.first.id);
      }
    });
  }

  Future<void> fetchProvinces() async {
    try {
      final response = await http.get(
        Uri.parse('${portApi}provinces'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['data'] as List;
        provinces.value = list.map((e) => ProvinceModel.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load provinces');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load provinces');
    }
  }

  Future<void> fetchDistricts({required int provinceId}) async {
    try {
      final response = await http.get(
        Uri.parse('${portApi}districts?province_id=$provinceId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['data'] as List;
        districts.value = list.map((e) => DistrictModel.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load districts');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load districts');
    }
  }

  Future<void> fetchCommunes({required int districtId}) async {
    try {
      final response = await http.get(
        Uri.parse('${portApi}communes?district_id=$districtId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['data'] as List;
        communes.value = list.map((e) => CommuneModel.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load communes');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load communes');
    }
  }
}
