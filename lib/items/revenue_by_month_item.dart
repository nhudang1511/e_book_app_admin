import 'package:e_book_admin/entities/entities.dart';

class RevenueByMonthItem extends RevenueByMonthEntity {
  RevenueByMonthItem({
    required super.jan,
    required super.feb,
    required super.mar,
    required super.apr,
    required super.may,
    required super.jun,
    required super.jul,
    required super.aug,
    required super.sep,
    required super.oct,
    required super.nov,
    required super.dec,
  });

  factory RevenueByMonthItem.fromJson(Map<String, dynamic> json) {
    return RevenueByMonthItem(
      jan: json['1'],
      feb: json['2'],
      mar: json['3'],
      apr: json['4'],
      may: json['5'],
      jun: json['6'],
      jul: json['7'],
      aug: json['8'],
      sep: json['9'],
      oct: json['10'],
      nov: json['11'],
      dec: json['12'],
    );
  }
}
