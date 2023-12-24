import '../../../../core/firebase/firebase_service_result.dart';

abstract class DashboardRepository {
  Future<FirebaseResult<dynamic>> getReports();
  Future<FirebaseResult<dynamic>> postReports(event);
}
