import 'package:e_commerce_app/app/modules/activity/data/models/activity_base_models.dart';

import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/activity_bloc.dart';

class ActivityPutRequest extends FirebaseRequest<ListActivityModels> {
  final ActivityEvent? event;
  ActivityPutRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.put;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.puActivity;

  @override
  Map<String, dynamic>? get params => {
        'id': event?.models?.id,
        'cash': event?.models?.cash,
        'is_pay': event?.models?.isPay,
        'refund_amount': event?.models?.refundAmount,
      };

  @override
  ListActivityModels Function(Map<String, dynamic> p1) get decoder =>
      ListActivityModels.fromJson;
}
