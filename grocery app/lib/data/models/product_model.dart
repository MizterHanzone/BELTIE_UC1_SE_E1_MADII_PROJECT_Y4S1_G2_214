class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String uom;
  final String photo;
  final String brand;
  final String category;
  final int categoryId;
  final int favoriteCount;
  final double rating;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.uom,
    required this.photo,
    required this.brand,
    required this.category,
    required this.categoryId,
    required this.favoriteCount,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      uom: json['uom'],
      photo: json['photo'],
      brand: json['brand'],
      category: json['category'],
      categoryId: json['category_id'],
      favoriteCount: json['favorite_count'] ?? 0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price.toString(),
      'uom': uom,
      'photo': photo,
      'brand': brand,
      'category_id': category,
      'favorite_count': favoriteCount,
      'rating': rating,
    };
  }

  static List<ProductModel> listFromJson(List<dynamic> data) {
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
