import '../helpers/app_logger.dart';
import 'firebase_service_authentication.dart';
import 'firebase_service_firestore.dart';
import 'firebase_service_request.dart';
import 'firebase_service_result.dart';
import 'firebase_service_result_type.dart';
import 'firebase_service_type.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._();
  FirebaseService._();
  static FirebaseService get instance => _instance;

  Future<FirebaseResult<T>> request<T>(FirebaseRequest<T> request) async {
    try {
      switch (request.type) {
        case FirebaseType.authentication:
          final response =
              await FirebaseServiceAuth.instance.authRequest(request);
          debugPrint(request, response);
          return response;
        case FirebaseType.firestore:
          final response =
              await FirebaseServiceFirestore.instance.firestoreRequest(request);
          debugPrint(request, response);
          return response;
        default:
          return FirebaseResult<T>(
            resultType: FirebaseResultType.error,
            message: 'Firebase Sercive Exception ',
          );
      }
    } catch (e) {
      return FirebaseResult<T>(
        resultType: FirebaseResultType.error,
        message: 'Firebase Sercive Exception: $e',
      );
    }
  }

  Future<void> debugPrint(
      FirebaseRequest request, FirebaseResult result) async {
    AppLogger.logDebug('--------------- REQUEST & RESPONSE ---------------');
    AppLogger.logDebug('Firebase Type: ${request.type}');
    AppLogger.logDebug('Authentication Type: ${request.authenticationType}');
    AppLogger.logDebug('Firestore Type: ${request.firestoreType}');
    AppLogger.logDebug('Parameters: ${request.params}');
    AppLogger.logDebug('Result Data: ${result.data}');
    AppLogger.logDebug('Result DataType: ${result.data.runtimeType}');
    AppLogger.logDebug('Result Message: ${result.message}');
    AppLogger.logDebug('Result Type: ${result.resultType}');
    AppLogger.logDebug('--------------------------------------------------');
  }
}
