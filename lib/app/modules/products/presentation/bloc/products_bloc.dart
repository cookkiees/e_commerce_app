import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/firebase_service_result_type.dart';
import '../../data/models/product_base_models.dart';
import '../../data/repositories/products_repository_impl.dart';
import '../../domain/entities/products_base_entity.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitialState()) {
    on<ProductsPosEvent>((event, emit) => handlePosProducts(event, emit));
    on<ProductsGetInitialEvent>(
        (event, emit) => handleProducts(event, emit, true));
    on<ProductsGetRefreshEvent>(
        (event, emit) => handleProducts(event, emit, false));
  }

  Future<void> handleProducts(ProductsEvent event, emit, isLoading) async {
    if (isLoading) {
      emit(ProductsLoadingState());
      await Future.delayed(const Duration(seconds: 1));
    }

    final products = await prosessGetProducts(event, emit);
    emit(ProductsGetSuccessState(entity: products));
  }

  Future<ListProductsModels?> prosessGetProducts(
      ProductsEvent event, Emitter<ProductsState> emit) async {
    try {
      final response = await ProductsRepositoryImpl.instance.getProducts();
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(ProductsGetSuccessState(entity: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(ProductsFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ProductsErrorState(error: response.message));
          return response.data;
        default:
          return null;
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
      return null;
    }
  }

  Future<ProductsModels?> handlePosProducts(
      ProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());
    try {
      final response = await ProductsRepositoryImpl.instance.posProducts(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(ProductsPostSuccessState(entity: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(ProductsFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ProductsErrorState(error: response.message));
          return response.data;

        default:
          return null;
      }
    } catch (e) {
      emit(ProductsErrorState(error: e.toString()));
      return null;
    }
  }
}
