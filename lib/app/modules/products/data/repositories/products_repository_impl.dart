import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firebase_service_result.dart';
import '../../domain/repositories/products_repository.dart';
import '../../presentation/bloc/products_bloc.dart';
import '../sources/products_get_firestore_request.dart';
import '../sources/products_pos_firestore_request.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  static final ProductsRepositoryImpl _instance = ProductsRepositoryImpl._();
  ProductsRepositoryImpl._();
  static ProductsRepositoryImpl get instance => _instance;

  @override
  Future<FirebaseResult> deleteProducts(ProductsEvent event) {
    throw UnimplementedError();
  }

  @override
  Future<FirebaseResult> getProducts() async {
    var firestoreRequest = ProductsGetRequest();
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> posProducts(ProductsEvent event) async {
    var firestoreRequest = ProductsPosRequest(event);
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> updateProducts(ProductsEvent event) {
    throw UnimplementedError();
  }
}
