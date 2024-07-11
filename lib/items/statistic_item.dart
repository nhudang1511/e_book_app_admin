import 'package:e_book_admin/entities/entities.dart';
import 'package:e_book_admin/items/revenue_by_month_item.dart';

class StatisticItem extends StatisticEntity {
  StatisticItem({
    required super.totalUsers,
    required super.totalViews,
    required super.totalBooks,
    required super.totalMissions,
    required super.totalRevenues,
    required super.revenueByMonth,
  });

  factory StatisticItem.fromJson(Map<String, dynamic> json) {
    return StatisticItem(
      totalUsers: json['totalUsers'],
      totalViews: json['totalViews'],
      totalBooks: json['totalBooks'],
      totalMissions: json['totalMissions'],
      totalRevenues: json['totalRevenues'],
      revenueByMonth: RevenueByMonthItem.fromJson(json['revenueByMonth']),
    );
  }
}
