part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  final ListProductsEntity? entity;
  final String? error;
  final String? success;
  final String? failure;
  const ProductsState({this.entity, this.success, this.error, this.failure});

  @override
  List<Object?> get props => [entity, error, failure];
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsGetRefreshState extends ProductsState {}

class ProductsGetSuccessState extends ProductsState {
  const ProductsGetSuccessState({super.entity, super.success});
}

class ProductsPostSuccessState extends ProductsState {
  const ProductsPostSuccessState({super.entity, super.success});
}

class ProductsFailureState extends ProductsState {
  const ProductsFailureState({super.failure});
}

class ProductsErrorState extends ProductsState {
  const ProductsErrorState({super.error});
}
