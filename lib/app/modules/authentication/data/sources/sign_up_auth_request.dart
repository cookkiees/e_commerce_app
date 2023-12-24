import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/auth_bloc.dart';
import '../models/auth_user_models.dart';

class SignUpRequest extends FirebaseRequest<AuthUserModels> {
  final AuthEvent event;
  SignUpRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.authentication;
  @override
  AuthenticationType? get authenticationType => AuthenticationType.signUp;
  @override
  FirestoreType? get firestoreType => FirestoreType.post;
  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.postUser;

  @override
  Map<String, dynamic>? get params => {
        'email': event.email,
        'password': event.password,
        'username': "${event.firstname} ${event.lastname}",
        'date_of_birth': event.birthday,
      };

  @override
  AuthUserModels Function(Map<String, dynamic> p1) get decoder =>
      throw UnimplementedError();
}

class SignInFirestoreRequest extends FirebaseRequest {
  final AuthEvent event;
  AuthUserModels? user;
  SignInFirestoreRequest(this.user, this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.post;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.postUser;

  @override
  Map<String, dynamic>? get params => {
        'user': user,
        'username': "${event.firstname} ${event.lastname}",
        'date_of_birth': event.birthday,
      };

  @override
  AuthUserModels Function(Map<String, dynamic> p1) get decoder =>
      throw UnimplementedError();
}
