import '../../domain/entities/customers_entity.dart';

class ListCustomersModels extends ListCustomersEntity {
  const ListCustomersModels({super.customers});
  factory ListCustomersModels.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? csutomersJson = json['customers'];
    // ignore: prefer_null_aware_operators
    final List<CustomersEntity>? customers = csutomersJson != null
        ? csutomersJson
            .map((csutomersJson) =>
                CustomersModels.fromJson(csutomersJson as Map<String, dynamic>))
            .toList()
        : null;

    return ListCustomersModels(customers: customers);
  }

  Map<String, dynamic> toJson() {
    return {
      'reports': customers?.map((activity) => activity.toJson()).toList(),
    };
  }
}

class CustomersModels extends CustomersEntity {
  const CustomersModels({super.id, super.lastOrder, super.name});

  factory CustomersModels.fromJson(Map<String, dynamic> json) {
    return CustomersModels(
      id: json['id'],
      name: json['name'],
      lastOrder: json['last_order'],
    );
  }
}
