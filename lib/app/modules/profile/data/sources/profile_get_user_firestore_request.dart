import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/profile_bloc.dart';
import '../models/profile_user_base_models.dart';

class ProfileGetUserRequest extends FirebaseRequest<ProfileUserModels> {
  final ProfileEvent event;
  ProfileGetUserRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.get;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.getUser;

  @override
  Map<String, dynamic>? get params => {};

  @override
  ProfileUserModels Function(Map<String, dynamic> p1) get decoder =>
      ProfileUserModels.fromJson;
}
