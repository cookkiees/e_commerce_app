import 'package:e_commerce_app/app/modules/activity/data/models/activity_base_models.dart';

import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';

class ActivityGetRequest extends FirebaseRequest<ListActivityModels> {
  ActivityGetRequest();

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.get;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.getActivity;

  @override
  Map<String, dynamic>? get params => {};

  @override
  ListActivityModels Function(Map<String, dynamic> p1) get decoder =>
      ListActivityModels.fromJson;
}
