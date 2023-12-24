import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/profile_bloc.dart';
import '../models/profile_user_base_models.dart';

class ProfileUpdateUserRequest extends FirebaseRequest<ProfileUserModels> {
  final ProfileEvent event;
  ProfileUpdateUserRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.put;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.putUser;

  @override
  Map<String, dynamic>? get params => {
        'display_name': event.username,
        'phone_number': event.phoneNumber,
      };

  @override
  ProfileUserModels Function(Map<String, dynamic> p1) get decoder =>
      ProfileUserModels.fromJson;
}
