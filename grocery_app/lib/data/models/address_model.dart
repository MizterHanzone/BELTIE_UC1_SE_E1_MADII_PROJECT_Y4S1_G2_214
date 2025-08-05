class AddressResponse {
  final bool success;
  final String message;
  final List<UserAddress> data;

  AddressResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      success: json['success'],
      message: json['message'],
      data: List<UserAddress>.from(
        json['data'].map((x) => UserAddress.fromJson(x)),
      ),
    );
  }
}

class UserAddress {
  final int id;
  final String phone;
  final String village;
  final String street;
  final String houseNumber;
  final String province;
  final String district;
  final String commune;
  final String latitude;
  final String longitude;

  UserAddress({
    required this.id,
    required this.phone,
    required this.village,
    required this.street,
    required this.houseNumber,
    required this.province,
    required this.district,
    required this.commune,
    required this.latitude,
    required this.longitude,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'],
      phone: json['phone'],
      village: json['village'],
      street: json['street'],
      houseNumber: json['house_number'],
      province: json['province'],
      district: json['district'],
      commune: json['commune'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
