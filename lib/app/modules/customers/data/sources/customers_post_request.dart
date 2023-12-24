import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/customers_bloc.dart';
import '../models/customers_models.dart';

class CustomersPostRequest extends FirebaseRequest<ListCustomersModels> {
  final CustomersEvent? event;
  CustomersPostRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.post;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.postCustomers;

  @override
  Map<String, dynamic>? get params => {
        'name': event?.models?.name,
        'last_order': event?.models?.lastOrder,
      };

  @override
  ListCustomersModels Function(Map<String, dynamic> p1) get decoder =>
      ListCustomersModels.fromJson;
}
