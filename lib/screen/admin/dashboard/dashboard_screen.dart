import 'package:e_book_admin/items/items.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:e_book_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import 'components/dashboard_row2.dart';
import '../components/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late StatisticItem? statisticItem;
  late StatisticRepository statisticRepository = StatisticRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatisticItem?>(
        future: statisticRepository.getStatistic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              return SafeArea(
                child: Drawer(
                  backgroundColor: Theme.of(context).colorScheme.onBackground,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Header(
                          title: 'Dashboard',
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: GridView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 1.8,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return TotalItems(
                                  recentData: RecentData(
                                      icon: Icons.group_sharp,
                                      title: 'Total users',
                                      number: snapshot.data!.totalUsers),
                                );
                              }
                              if (index == 1) {
                                return TotalItems(
                                  recentData: RecentData(
                                      icon: Icons.visibility,
                                      title: 'Total views',
                                      number: snapshot.data!.totalViews),
                                );
                              }
                              if (index == 2) {
                                return TotalItems(
                                  recentData: RecentData(
                                    icon: Icons.menu_book_sharp,
                                    title: 'Total books',
                                    number: snapshot.data!.totalBooks,
                                  ),
                                );
                              }
                              if (index == 3) {
                                return TotalItems(
                                  recentData: RecentData(
                                    icon: Icons.task_alt,
                                    title: 'Total missions',
                                    number: snapshot.data!.totalMissions,
                                  ),
                                );
                              }
                              if (index == 4) {
                                return TotalItems(
                                  recentData: RecentData(
                                    icon: Icons.attach_money,
                                    title: 'Revenue',
                                    number: snapshot.data!.totalRevenues,
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                        DashBoardRow2(
                          revenueByMonthItem: snapshot.data!.revenueByMonth,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return const Loading();
        });
  }
}

class TotalItems extends StatelessWidget {
  const TotalItems({
    super.key,
    required this.recentData,
  });

  final RecentData recentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${recentData.number} \n${recentData.title}',
              style: (Responsive.isMobile(context))
                  ? const TextStyle(fontSize: 13, color: Colors.white)
                  : (Responsive.isTablet(context))
                      ? Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white)
                      : Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.white),
              textAlign: TextAlign.center),
          if (!Responsive.isMobile(context))
            Icon(
              recentData.icon,
              color: Colors.white,
              size: MediaQuery.of(context).size.height /
                  (Responsive.isTablet(context) ? 15 : 8),
            )
        ],
      ),
    );
  }
}

class RecentData {
  final int number;
  final String title;
  final IconData icon;

  RecentData({required this.icon, required this.title, required this.number});
}
