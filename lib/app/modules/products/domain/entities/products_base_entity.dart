import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class ListProductsEntity extends Equatable {
  final List<ProductsEntity>? products;

  const ListProductsEntity({this.products});

  @override
  List<Object?> get props => [products];
}

// ignore: must_be_immutable
class ProductsEntity extends Equatable {
  final int? id;
  final RxInt quantity;
  final RxBool isInCart;
  final String? basicPrice;
  final String? salePrice;
  final String? name;
  final String? category;
  final String? description;
  final dynamic imageUrl;

  ProductsEntity({
    this.id,
    this.name,
    this.category,
    int? quantity,
    bool isInCart = false,
    this.basicPrice,
    this.salePrice,
    this.description,
    this.imageUrl,
  })  : quantity = RxInt(quantity ?? 0),
        isInCart = RxBool(isInCart);

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        basicPrice,
        salePrice,
        description,
        imageUrl,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'basic_price': basicPrice,
      'sale_price': salePrice,
      'description': description,
      'image_url': imageUrl,
    };
  }
}
