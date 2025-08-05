class CategoryWithProductModel {
  final String categoryName;
  final String categoryPhoto;
  final List<Product> products;

  CategoryWithProductModel({
    required this.categoryName,
    required this.categoryPhoto,
    required this.products,
  });

  factory CategoryWithProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryWithProductModel(
      categoryName: json['category_name'],
      categoryPhoto: json['category_photo'],
      products: List<Product>.from(json['product'].map((p) => Product.fromJson(p))),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String uom;
  final String photo;
  final String brand;
  final int favoriteCount;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.uom,
    required this.photo,
    required this.brand,
    required this.favoriteCount,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      uom: json['uom'],
      photo: json['photo'],
      brand: json['brand'],
      favoriteCount: json['favorite_count'] ?? 0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }
}
