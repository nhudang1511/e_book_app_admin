import 'package:e_book_admin/items/items.dart';

class StatisticEntity {
  final int totalUsers;
  final int totalViews;
  final int totalBooks;
  final int totalMissions;
  final int totalRevenues;
  final RevenueByMonthItem revenueByMonth;

  StatisticEntity({
    required this.totalUsers,
    required this.totalViews,
    required this.totalBooks,
    required this.totalMissions,
    required this.totalRevenues,
    required this.revenueByMonth,
  });
}
