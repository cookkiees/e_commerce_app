import 'firebase_service_method_type.dart';
import 'firebase_service_type.dart';

abstract class FirebaseRequest<T> {
  Map<String, dynamic>? get params;
  T Function(Map<String, dynamic>) get decoder;
  FirebaseType get type;
  FirestoreType? get firestoreType;
  FirestoreUseCaseType? get firestoreUsecaseType;
  AuthenticationType? get authenticationType;
}
