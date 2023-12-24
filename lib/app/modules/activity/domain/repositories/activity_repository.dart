import 'package:e_commerce_app/app/modules/activity/presentation/bloc/activity_bloc.dart';

import '../../../../core/firebase/firebase_service_result.dart';

abstract class ActivityRepository {
  Future<FirebaseResult<dynamic>> getActivity();
  Future<FirebaseResult<dynamic>> postActivity(ActivityEvent event);
  Future<FirebaseResult<dynamic>> putActivity(ActivityEvent event);
}
