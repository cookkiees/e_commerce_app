import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firebase_service_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/bloc/auth_bloc.dart';
import '../models/auth_user_models.dart';
import '../sources/sign_in_auth_request.dart';
import '../sources/sign_up_auth_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  static final AuthRepositoryImpl _instance = AuthRepositoryImpl._();
  AuthRepositoryImpl._();
  static AuthRepositoryImpl get instance => _instance;

  @override
  Future<FirebaseResult<AuthUserModels>> getSignIn(AuthEvent event) async {
    SignInAuthRequest authRequest = SignInAuthRequest(event);
    var response = await FirebaseService.instance.request(authRequest);

    return response;
  }

  @override
  Future<FirebaseResult<AuthUserModels>> getSignUp(AuthEvent event) async {
    SignUpRequest request = SignUpRequest(event);
    var response = await FirebaseService.instance.request(request);

    var firestoreRequest = SignInFirestoreRequest(response.data, event);
    await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult<dynamic>> getSignInGoogle(AuthEvent event) {
    throw UnimplementedError();
  }
}
