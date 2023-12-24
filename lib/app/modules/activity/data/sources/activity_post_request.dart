import 'package:e_commerce_app/app/modules/activity/data/models/activity_base_models.dart';

import '../../../../core/firebase/firebase_service_method_type.dart';
import '../../../../core/firebase/firebase_service_request.dart';
import '../../../../core/firebase/firebase_service_type.dart';
import '../../presentation/bloc/activity_bloc.dart';

class ActivityPostRequest extends FirebaseRequest<ListActivityModels> {
  final ActivityEvent? event;
  ActivityPostRequest(this.event);

  @override
  FirebaseType get type => FirebaseType.firestore;

  @override
  AuthenticationType? get authenticationType => null;

  @override
  FirestoreType? get firestoreType => FirestoreType.post;

  @override
  FirestoreUseCaseType? get firestoreUsecaseType =>
      FirestoreUseCaseType.postActivity;

  @override
  Map<String, dynamic>? get params {
    final models = event?.models;

    if (models != null) {
      final List<Map<String, dynamic>> cartsData = models.carts?.map((cart) {
            return {
              'id': cart.id,
              'name': cart.name,
              'image_url': cart.imageUrl,
              'quantity': cart.quantity,
              'sale_price': cart.salePrice,
            };
          }).toList() ??
          [];

      return {
        'sub_total': models.subTotal,
        'discount': models.discount,
        'tax': models.tax,
        'total': models.total,
        'cash': models.cash,
        'is_pay': models.isPay,
        'refund_amount': models.refundAmount,
        'customer_name': models.customerName,
        'pay_date': models.payDate,
        'pay_time': models.payTime,
        'carts': cartsData,
      };
    }
    return null;
  }

  @override
  ListActivityModels Function(Map<String, dynamic> p1) get decoder =>
      ListActivityModels.fromJson;
}
