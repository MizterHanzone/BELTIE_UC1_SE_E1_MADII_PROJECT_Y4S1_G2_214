import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';
import 'package:online_grocery_delivery_app/data/models/address_model.dart';

class GAddress extends GetxController {
  final addresses = <UserAddress>[].obs;
  final isLoading = false.obs;
  final storage = GetStorage();

  String get token => storage.read('token') ?? '';

  Map<String, String> get headers => {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    try {
      final response = await http.get(
          Uri.parse('${portApi}address/get'),
          headers: headers
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = data['data'] as List;
        addresses.value = list.map((e) => UserAddress.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load addresses');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load addresses');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> storeAddress({
    required int provinceId,
    required int districtId,
    required int communeId,
    String? village,
    String? street,
    String? houseNumber,
    String? latitude,
    String? longitude,
  }) async {
    try {
      final body = {
        'province_id': provinceId.toString(),
        'district_id': districtId.toString(),
        'commune_id': communeId.toString(),
        'village': village,
        'street': street,
        'house_number': houseNumber,
        'latitude': latitude,
        'longitude': longitude,
      };

      final response = await http.post(
        Uri.parse('$portApi/addresses'),
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Address saved');
        fetchAddresses(); // Refresh list
      } else {
        final msg = jsonDecode(response.body)['message'];
        Get.snackbar('Error', msg ?? 'Failed to save address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save address');
    }
  }

  Future<void> updateAddress({
    required int id,
    required int provinceId,
    required int districtId,
    required int communeId,
    String? village,
    String? street,
    String? houseNumber,
    String? latitude,
    String? longitude,
  }) async {
    try {
      final body = {
        'province_id': provinceId.toString(),
        'district_id': districtId.toString(),
        'commune_id': communeId.toString(),
        'village': village,
        'street': street,
        'house_number': houseNumber,
        'latitude': latitude,
        'longitude': longitude,
      };

      final response = await http.put(
        Uri.parse('$portApi/addresses/$id'),
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Address updated');
        fetchAddresses(); // Refresh list
      } else {
        final msg = jsonDecode(response.body)['message'];
        Get.snackbar('Error', msg ?? 'Failed to update address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update address');
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$portApi/addresses/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        addresses.removeWhere((a) => a.id == id);
        Get.snackbar('Success', 'Address deleted');
      } else {
        Get.snackbar('Error', 'Failed to delete address');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete address');
    }
  }
}
