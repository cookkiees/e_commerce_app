import 'package:e_commerce_app/app/modules/customers/presentation/bloc/customers_bloc.dart';

import '../../../../core/firebase/firebase_service_result.dart';

abstract class CustomersRepository {
  Future<FirebaseResult<dynamic>> getCustomers();
  Future<FirebaseResult<dynamic>> postCustomers(CustomersEvent event);
}
