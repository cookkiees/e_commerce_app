enum ActivityCategory { paymentCompleted, paymentPending }

extension ActicvityCategoryExtension on ActivityCategory {
  String get name {
    switch (this) {
      case ActivityCategory.paymentCompleted:
        return 'PAYMENT COMPLETED';
      case ActivityCategory.paymentPending:
        return 'PAYMENT PENDING';
      default:
        return '';
    }
  }

  bool get isPay {
    switch (this) {
      case ActivityCategory.paymentCompleted:
        return true;
      case ActivityCategory.paymentPending:
        return false;
      default:
        return false;
    }
  }
}
