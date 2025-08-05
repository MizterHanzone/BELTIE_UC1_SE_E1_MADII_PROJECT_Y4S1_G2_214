import 'package:online_grocery_delivery_app/core/helpers/connection/url_connection.dart';

class CartItemModel {
  final int id;
  final int productId;
  final String name;
  final String photo;
  final int quantity;
  final double price;
  final double currentPrice;
  final double subtotal;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.photo,
    required this.quantity,
    required this.price,
    required this.currentPrice,
    required this.subtotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: int.parse(json['id'].toString()),
      productId: int.parse(json['product_id'].toString()),
      name: json['name'],
      photo: json['photo'],
      quantity: int.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
      currentPrice: double.parse(json['current_price'].toString()),
      subtotal: double.parse(json['subtotal'].toString()),
    );
  }
}
