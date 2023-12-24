import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../models/customers_models.dart';

class CustomersGetRequest extends FirebaseRequest<ListCustomersModels> {
  CustomersGetRequest();

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.get;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.getCustomers;

  @override
  Map<String, dynamic>? get params => {};

  @override
  ListCustomersModels Function(Map<String, dynamic> p1) get decoder =>
      ListCustomersModels.fromJson;
}
