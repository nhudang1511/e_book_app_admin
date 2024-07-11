import '../../items/items.dart';

abstract class BaseStatisticRepository {
  Future<StatisticItem?> getStatistic();
}