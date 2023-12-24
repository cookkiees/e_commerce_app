import '../../../../core/firebase/firebase_service_result.dart';
import '../../presentation/bloc/products_bloc.dart';

abstract class ProductsRepository {
  Future<FirebaseResult<dynamic>> getProducts();
  Future<FirebaseResult<dynamic>> posProducts(ProductsEvent models);
  Future<FirebaseResult<dynamic>> updateProducts(ProductsEvent event);
  Future<FirebaseResult<dynamic>> deleteProducts(ProductsEvent event);
}
