import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/app_logger.dart';
import 'firebase_service_firestore_usecase.dart';
import 'firebase_service_method_type.dart';
import 'firebase_service_request.dart';
import 'firebase_service_result.dart';
import 'firebase_service_result_type.dart';

class FirebaseServiceFirestore {
  static final FirebaseServiceFirestore _instance =
      FirebaseServiceFirestore._();
  FirebaseServiceFirestore._();
  static FirebaseServiceFirestore get instance => _instance;

  Future<FirebaseResult<T>> firestoreRequest<T>(
      FirebaseRequest<T> request) async {
    try {
      switch (request.firestoreType) {
        case FirestoreType.get:
          final data = await FirestoreUseCase.instance.getFirestoreUseCase(
            request: request,
            usecaseType: request.firestoreUsecaseType,
          );
          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Firestore GET Succesfull',
            data: request.decoder(data),
          );

        case FirestoreType.post:
          final data = await FirestoreUseCase.instance.postFirestoreUseCase(
            usecaseType: request.firestoreUsecaseType,
            request: request,
            user: request.params?['user'],
            username: request.params?['username'],
            dateofBirth: request.params?['date_of_birth'],
          );
          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Firestore POST Succesfull',
            data: data,
          );
        case FirestoreType.put:
          final data = await FirestoreUseCase.instance.putFirestoreUseCase(
            request: request,
            usecaseType: request.firestoreUsecaseType,
          );
          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Firestore PUT Succesfull',
            data: data,
          );
        case FirestoreType.delete:
          final data = await FirestoreUseCase.instance.deleteFirestoreUseCase(
            request: request,
            usecaseType: request.firestoreUsecaseType,
          );
          return FirebaseResult<T>(
            resultType: FirebaseResultType.success,
            message: 'Firebase Firestore DELETE Succesfull',
            data: data,
          );
        default:
          return FirebaseResult<T>(
            resultType: FirebaseResultType.failure,
            message: 'Firebase Firestore Failure',
          );
      }
    } on FirebaseException catch (e) {
      return FirebaseResult<T>(
        resultType: FirebaseResultType.error,
        message: 'Firebase Exception: ${e.message}',
      );
    } catch (e) {
      return FirebaseResult<T>(
        resultType: FirebaseResultType.error,
        message: 'Exception: $e',
      );
    }
  }

  Future<void> debugPrint(
      FirebaseRequest request, FirebaseResult result) async {
    AppLogger.logDebug('--------------- REQUEST & RESPONSE ---------------');
    AppLogger.logDebug('Firebase Type: ${request.type}');
    AppLogger.logDebug('Firestore Type: ${request.firestoreType}');
    AppLogger.logDebug('Parameters: ${request.params}');
    AppLogger.logDebug('Result Data: ${result.data}');
    AppLogger.logDebug('Result DataType: ${result.data.runtimeType}');
    AppLogger.logDebug('Result Message: ${result.message}');
    AppLogger.logDebug('Result Type: ${result.resultType}');
    AppLogger.logDebug('--------------------------------------------------');
  }
}
