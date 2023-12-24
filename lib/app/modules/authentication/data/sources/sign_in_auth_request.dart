import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/auth_bloc.dart';
import '../models/auth_user_models.dart';

class SignInAuthRequest extends FirebaseRequest<AuthUserModels> {
  final AuthEvent event;
  SignInAuthRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.authentication;

  @override
  AuthenticationType? get authenticationType => AuthenticationType.signIn;

  @override
  FirestoreType? get firestoreType => FirestoreType.post;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.postUser;

  @override
  Map<String, dynamic>? get params => {
        'email': event.email,
        'password': event.password,
      };

  @override
  AuthUserModels Function(Map<String, dynamic> p1) get decoder =>
      throw UnimplementedError();
}
