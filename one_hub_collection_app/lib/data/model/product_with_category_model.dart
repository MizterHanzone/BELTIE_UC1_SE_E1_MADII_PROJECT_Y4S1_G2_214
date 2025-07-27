import 'package:one_hub_collection_app/data/model/product_model.dart';

class CategoryWithProducts {
  final String categoryName;
  final String categoryDescription;
  final List<ProductModel> products;

  CategoryWithProducts({
    required this.categoryName,
    required this.categoryDescription,
    required this.products,
  });

  factory CategoryWithProducts.fromJson(Map<String, dynamic> json) {
    return CategoryWithProducts(
      categoryName: json['category_name'],
      categoryDescription: json['category_description'],
      products: (json['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_name': categoryName,
      'category_description': categoryDescription,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}
