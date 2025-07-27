class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  // final int quantity;
  final String photo;
  final String brand;
  final String category;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    // required this.quantity,
    required this.photo,
    required this.brand,
    required this.category,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      // quantity: json['quantity'],
      photo: json['photo'],
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      categoryId: json['category_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      // 'quantity': quantity,
      'photo': photo,
      'category': category,
      'category_id': categoryId,
    };
  }

  static List<ProductModel> listFromJson(List<dynamic> data) {
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
