import '../../../../core/firebase/firebase_service_result.dart';
import '../../presentation/bloc/auth_bloc.dart';

abstract class AuthRepository {
  Future<FirebaseResult<dynamic>> getSignIn(AuthEvent event);
  Future<FirebaseResult<dynamic>> getSignUp(AuthEvent event);
  Future<FirebaseResult<dynamic>> getSignInGoogle(AuthEvent event);
}
