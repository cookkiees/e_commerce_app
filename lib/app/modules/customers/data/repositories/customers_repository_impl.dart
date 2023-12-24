import 'package:e_commerce_app/app/core/firebase/firebase_service_result.dart';
import 'package:e_commerce_app/app/modules/customers/domain/repositories/customers_repository.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../sources/customers_get_request.dart';
import '../sources/customers_post_request.dart';

class CustomersRepositoryImpl implements CustomersRepository {
  static final CustomersRepositoryImpl _instance = CustomersRepositoryImpl._();
  CustomersRepositoryImpl._();
  static CustomersRepositoryImpl get instance => _instance;
  @override
  Future<FirebaseResult> getCustomers() async {
    var firestoreRequest = CustomersGetRequest();
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }

  @override
  Future<FirebaseResult> postCustomers(event) async {
    var firestoreRequest = CustomersPostRequest(event);
    var response = await FirebaseService.instance.request(firestoreRequest);
    return response;
  }
}
