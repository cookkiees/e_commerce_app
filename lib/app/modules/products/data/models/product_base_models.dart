import '../../domain/entities/products_base_entity.dart';

class ListProductsModels extends ListProductsEntity {
  const ListProductsModels({super.products});

  factory ListProductsModels.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? productsJson = json['products'];
    // ignore: prefer_null_aware_operators
    final List<ProductsEntity>? products = productsJson != null
        ? productsJson
            .map((productJson) =>
                ProductsModels.fromJson(productJson as Map<String, dynamic>))
            .toList()
        : null;

    return ListProductsModels(products: products);
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((product) => product.toJson()).toList(),
    };
  }
}

// ignore: must_be_immutable
class ProductsModels extends ProductsEntity {
  ProductsModels(
      {super.id,
      super.quantity,
      super.name,
      super.category,
      super.basicPrice,
      super.salePrice,
      super.isInCart,
      super.description,
      super.imageUrl});

  factory ProductsModels.fromJson(Map<String, dynamic> json) {
    return ProductsModels(
      id: json['id'],
      quantity: json['quantity'],
      name: json['name'],
      category: json['category'],
      basicPrice: json['basic_price'],
      salePrice: json['sale_price'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}
