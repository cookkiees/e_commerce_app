import '../../domain/entities/activity_base_entity.dart';

class ListActivityModels extends ListActivityEntity {
  const ListActivityModels({super.activity});

  factory ListActivityModels.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? activityJson = json['activity'];
    // ignore: prefer_null_aware_operators
    final List<ActivityEntity>? activity = activityJson != null
        ? activityJson
            .map((acticityJson) =>
                ActivityModels.fromJson(acticityJson as Map<String, dynamic>))
            .toList()
        : null;

    return ListActivityModels(activity: activity);
  }

  Map<String, dynamic> toJson() {
    return {
      'reports': activity?.map((activity) => activity.toJson()).toList(),
    };
  }
}

class ActivityModels extends ActivityEntity {
  const ActivityModels({
    super.id,
    super.subTotal,
    super.discount,
    super.tax,
    super.total,
    super.cash,
    super.refundAmount,
    super.isPay,
    super.customerName,
    super.carts,
    super.payDate,
    super.payTime,
  });

  factory ActivityModels.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? cartsJson = json['carts'];
    // ignore: prefer_null_aware_operators
    final List<CartsEntity>? carts = cartsJson != null
        ? cartsJson
            .map((cartJson) =>
                CartsModels.fromJson(cartJson as Map<String, dynamic>))
            .toList()
        : null;
    return ActivityModels(
      id: json['id'],
      subTotal: json['sub_total'],
      discount: json['discount'],
      tax: json['tax'],
      total: json['total'],
      cash: json['cash'],
      isPay: json['is_pay'],
      refundAmount: json['refund_amount'],
      customerName: json['customer_name'],
      carts: carts,
      payDate: json['pay_date'],
      payTime: json['pay_time'],
    );
  }
}

class CartsModels extends CartsEntity {
  const CartsModels({
    super.name,
    super.salePrice,
    super.id,
    super.imageUrl,
    super.quantity,
  });

  factory CartsModels.fromJson(Map<String, dynamic> json) {
    return CartsModels(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      salePrice: json['sale_price'],
      imageUrl: json['image_url'],
    );
  }
}
