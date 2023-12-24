enum CustomersCategory {
  all,
  today,
}

extension CustomersCategoryExtension on CustomersCategory {
  String get name {
    switch (this) {
      case CustomersCategory.all:
        return 'All';
      case CustomersCategory.today:
        return 'Today';

      default:
        return '';
    }
  }
}
