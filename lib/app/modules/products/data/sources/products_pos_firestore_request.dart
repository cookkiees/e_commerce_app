import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/products_bloc.dart';
import '../models/product_base_models.dart';

class ProductsPosRequest extends FirebaseRequest<ListProductsModels> {
  final ProductsEvent event;
  ProductsPosRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.post;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.postProduct;

  @override
  Map<String, dynamic>? get params => {
        'quantity': 1,
        'name': event.product?.name,
        'category': event.product?.category,
        'basic_price': event.product?.basicPrice,
        'sale_price': event.product?.salePrice,
        'description': event.product?.description,
        'image_url': event.product?.imageUrl,
      };

  @override
  ListProductsModels Function(Map<String, dynamic> p1) get decoder =>
      ListProductsModels.fromJson;
}
