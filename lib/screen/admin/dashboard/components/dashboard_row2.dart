import 'package:e_book_admin/items/items.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoardRow2 extends StatelessWidget {
  const DashBoardRow2({
    super.key,
    required this.revenueByMonthItem,
  });

  final RevenueByMonthItem revenueByMonthItem;

  List<ChartData> getData(RevenueByMonthItem revenueByMonthItem) {
    List<ChartData> list = [
      ChartData(1, revenueByMonthItem.jan),
      ChartData(2, revenueByMonthItem.feb),
      ChartData(3, revenueByMonthItem.mar),
      ChartData(4, revenueByMonthItem.apr),
      ChartData(5, revenueByMonthItem.may),
      ChartData(6, revenueByMonthItem.jun),
      ChartData(7, revenueByMonthItem.jul),
      ChartData(8, revenueByMonthItem.aug),
      ChartData(9, revenueByMonthItem.sep),
      ChartData(10, revenueByMonthItem.oct),
      ChartData(11, revenueByMonthItem.nov),
      ChartData(12, revenueByMonthItem.dec),
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(10),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<ChartData, int>(
                  dataSource: getData(revenueByMonthItem),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final int y;
}
