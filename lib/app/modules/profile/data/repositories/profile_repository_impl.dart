import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firebase_service_result.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../presentation/bloc/profile_bloc.dart';
import '../sources/profile_get_user_firestore_request.dart';
import '../sources/profile_update_user_firestore_request.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  static final ProfileRepositoryImpl _instance = ProfileRepositoryImpl._();
  ProfileRepositoryImpl._();
  static ProfileRepositoryImpl get instance => _instance;

  @override
  Future<FirebaseResult> getUser(ProfileEvent event) async {
    var firestoreRequest = ProfileGetUserRequest(event);
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> updateUser(ProfileEvent event) async {
    var firestoreRequest = ProfileUpdateUserRequest(event);
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> updateUserPassword(ProfileEvent event) {
    throw UnimplementedError();
  }

  @override
  Future<FirebaseResult> updateUserPhoto(ProfileEvent event) {
    throw UnimplementedError();
  }
}
