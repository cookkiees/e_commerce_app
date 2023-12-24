import 'firebase_service_result_type.dart';

class FirebaseResult<T> {
  FirebaseResultType? resultType;
  String? message;
  T? data;

  FirebaseResult({this.resultType, this.message, this.data});
}
