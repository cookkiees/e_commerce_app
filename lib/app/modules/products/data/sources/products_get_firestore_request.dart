import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../models/product_base_models.dart';

class ProductsGetRequest extends FirebaseRequest<ListProductsModels> {
  ProductsGetRequest();

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.get;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.getProduct;

  @override
  Map<String, dynamic>? get params => {};

  @override
  ListProductsModels Function(Map<String, dynamic> p1) get decoder =>
      ListProductsModels.fromJson;
}
