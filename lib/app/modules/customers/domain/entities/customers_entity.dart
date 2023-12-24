import 'package:equatable/equatable.dart';

class ListCustomersEntity extends Equatable {
  final List<CustomersEntity>? customers;

  const ListCustomersEntity({this.customers});

  @override
  List<Object?> get props => [customers];
}

class CustomersEntity extends Equatable {
  final int? id;
  final String? name;
  final String? lastOrder;

  const CustomersEntity({this.id, this.lastOrder, this.name});

  @override
  List<Object?> get props => [id, lastOrder, name];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_orders': lastOrder,
    };
  }
}
