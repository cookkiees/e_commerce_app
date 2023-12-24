import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/app/modules/authentication/data/models/auth_user_models.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helpers/app_prefs.dart';
import 'firebase_service_method_type.dart';
import 'firebase_service_request.dart';
import 'firebase_service_result.dart';
import 'firebase_service_result_type.dart';

class FirebaseServiceAuth {
  static final FirebaseServiceAuth _instance = FirebaseServiceAuth._();
  FirebaseServiceAuth._();
  static FirebaseServiceAuth get instance => _instance;

  Future<FirebaseResult<T>> authRequest<T>(FirebaseRequest<T> request) async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential;
    ConfirmationResult confirmationResult;
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      switch (request.authenticationType) {
        case AuthenticationType.resetPassword:
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: request.params?['email']);

          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Authentication Register Succesfull',
            data: null,
          );
        case AuthenticationType.signIn:
          userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: request.params?['email'],
            password: request.params?['password'],
          );
          AuthUserModels authUserCredential =
              AuthUserModels.fromUser(userCredential.user!);
          String? accessEmail = userCredential.user?.email;
          if (accessEmail != null) {
            await AppPrefs.saveEmail(accessEmail);
          }

          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Authentication Login Succesfull',
            data: authUserCredential as T,
          );
        case AuthenticationType.signUp:
          userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: request.params?['email'],
            password: request.params?['password'],
          );

          AuthUserModels authUserCredential =
              AuthUserModels.fromUser(userCredential.user!);
          String? accessEmail = userCredential.user?.email;
          if (accessEmail != null) {
            await AppPrefs.saveEmail(accessEmail);
          }

          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Authentication Register Succesfull',
            data: authUserCredential as T,
          );
        case AuthenticationType.google:
          final googleSignInAccount = await googleSignIn.signIn();
          final googleSignInAuth = await googleSignInAccount!.authentication;
          if (googleSignInAccount.serverAuthCode != null) {
            await AppPrefs.saveServerAuthCode(
                "${googleSignInAccount.serverAuthCode}");
          }
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuth.accessToken,
            idToken: googleSignInAuth.idToken,
          );
          userCredential = await firebaseAuth.signInWithCredential(credential);
          String? accessEmail = userCredential.user?.email;
          if (accessEmail != null) {
            await AppPrefs.saveEmail(accessEmail);
          }
          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Authentication Google Succesfull',
            data: userCredential as T,
          );
        case AuthenticationType.phoneNumber:
          confirmationResult = await firebaseAuth.signInWithPhoneNumber(
            request.params?['phone-number'],
          );
          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Authentication PhoneNumber Succesfull',
            data: confirmationResult as T,
          );

        default:
          return FirebaseResult<T>(
            resultType: FirebaseResultType.failure,
            message: 'Firebase Authentication Failure',
            data: null,
          );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'ERROR_INTERNAL_ERROR') {
        // Handle internal error
        return FirebaseResult<T>(
          resultType: FirebaseResultType.failure,
          message: '${e.message}',
        );
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        // Handle invalid login credentials
        return FirebaseResult<T>(
          resultType: FirebaseResultType.failure,
          message: e.code,
        );
      } else {
        // Handle other FirebaseAuthExceptions
        return FirebaseResult<T>(
          resultType: FirebaseResultType.failure,
          message: '${e.message}',
        );
      }
    } catch (e) {
      return FirebaseResult<T>(
        resultType: FirebaseResultType.error,
        message: 'Authentication Exception: $e',
      );
    }
  }
}
