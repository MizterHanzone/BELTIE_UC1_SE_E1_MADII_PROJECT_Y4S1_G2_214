class FavoriteModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String uom;
  final String photo;
  final String brand;
  final String favoriteById;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.uom,
    required this.photo,
    required this.brand,
    required this.favoriteById,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      uom: json['uom'],
      photo: json['photo'],
      brand: json['brand'],
      favoriteById: json['favorite_by_id'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'uom': uom,
      'photo': photo,
      'brand': brand,
      'favorite_by_id': favoriteById,
    };
  }

  static List<FavoriteModel> listFromJson(List<dynamic> data) {
    return data.map((e) => FavoriteModel.fromJson(e)).toList();
  }
}