import 'package:equatable/equatable.dart';

class ListActivityEntity extends Equatable {
  final List<ActivityEntity>? activity;

  const ListActivityEntity({this.activity});

  @override
  List<Object?> get props => [activity];
}

class ActivityEntity extends Equatable {
  final int? id;
  final num? subTotal;
  final num? discount;
  final num? tax;
  final num? total;
  final num? cash;
  final num? refundAmount;
  final bool? isPay;
  final String? customerName;
  final String? payDate;
  final String? payTime;
  final List<CartsEntity>? carts;

  const ActivityEntity({
    this.id,
    this.subTotal,
    this.discount,
    this.tax,
    this.total,
    this.cash,
    this.refundAmount,
    this.isPay,
    this.customerName,
    this.carts,
    this.payDate,
    this.payTime,
  });

  @override
  List<Object?> get props => [
        id,
        subTotal,
        discount,
        tax,
        total,
        cash,
        refundAmount,
        isPay,
        customerName,
        carts,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sub_total': subTotal,
      'discount': discount,
      'tax': tax,
      'total': total,
      'cash': cash,
      'refund_amount': refundAmount,
      'customer_name': customerName,
      'pay_date': payDate,
      'pay_time': payTime,
      'carts': carts,
    };
  }
}

class CartsEntity extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;
  final num? salePrice;
  final int? quantity;

  const CartsEntity(
      {this.name, this.salePrice, this.id, this.imageUrl, this.quantity});

  @override
  List<Object?> get props => [name, salePrice, id, imageUrl, quantity];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sale_price': salePrice,
      'image_url': imageUrl,
      'quantity': quantity,
    };
  }
}
