import 'package:e_commerce_app/app/core/firebase/firebase_service_result.dart';
import 'package:e_commerce_app/app/modules/activity/presentation/bloc/activity_bloc.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../../domain/repositories/activity_repository.dart';
import '../sources/activity_get_request.dart';
import '../sources/activity_post_request.dart';
import '../sources/activity_put_request.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  static final ActivityRepositoryImpl _instance = ActivityRepositoryImpl._();
  ActivityRepositoryImpl._();
  static ActivityRepositoryImpl get instance => _instance;

  @override
  Future<FirebaseResult> getActivity() async {
    var firestoreRequest = ActivityGetRequest();
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> postActivity(event) async {
    var firestoreRequest = ActivityPostRequest(event);
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> putActivity(ActivityEvent event) async {
    var firestoreRequest = ActivityPutRequest(event);
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }
}
