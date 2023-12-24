import '../../../../core/firebase/firebase_service_result.dart';
import '../../presentation/bloc/profile_bloc.dart';

abstract class ProfileRepository {
  Future<FirebaseResult<dynamic>> getUser(ProfileEvent event);
  Future<FirebaseResult<dynamic>> updateUserPhoto(ProfileEvent event);
  Future<FirebaseResult<dynamic>> updateUser(ProfileEvent event);
  Future<FirebaseResult<dynamic>> updateUserPassword(ProfileEvent event);
}
