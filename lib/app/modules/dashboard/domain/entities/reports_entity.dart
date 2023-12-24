import 'package:equatable/equatable.dart';

class ReportsEntity extends Equatable {
  final num? earnedToday;
  final num? totalEarned;
  final num? totalOrders;

  const ReportsEntity({
    this.earnedToday,
    this.totalEarned,
    this.totalOrders,
  });

  @override
  List<Object?> get props => [
        earnedToday,
        totalEarned,
        totalOrders,
      ];

  Map<String, dynamic> toJson() {
    return {
      'earned_today': earnedToday ?? 0,
      'total_earned': totalEarned ?? 0,
      'total_orders': totalOrders ?? 0,
    };
  }
}
