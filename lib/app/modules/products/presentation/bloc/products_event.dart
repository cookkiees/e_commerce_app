part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  final ProductsModels? product;

  const ProductsEvent({
    this.product,
  });

  @override
  List<Object?> get props => [product];
}

class ProductsPosEvent extends ProductsEvent {
  const ProductsPosEvent({super.product});
}

class ProductsGetInitialEvent extends ProductsEvent {
  const ProductsGetInitialEvent();
}

class ProductsGetRefreshEvent extends ProductsEvent {
  const ProductsGetRefreshEvent();
}
