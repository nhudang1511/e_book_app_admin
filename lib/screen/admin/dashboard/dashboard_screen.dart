import 'package:e_book_admin/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/responsive.dart';
import 'components/dashboard_row2.dart';
import '../components/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.2,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Chạy BlocA cho các index chẵn
                        return BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is UserLoaded) {
                              return TotalItems(
                                recentData: RecentData(
                                    icon: Icons.group_sharp,
                                    title: 'Total users',
                                    number: state.users.length),
                              );
                            } else {
                              return const Text("Something went wrong");
                            }
                          },
                        );
                      }
                      if (index == 1) {
                        return BlocBuilder<ViewBloc, ViewState>(
                          builder: (context, state) {
                            if (state is ViewLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is ViewLoaded) {
                              return TotalItems(
                                recentData: RecentData(
                                    icon: Icons.visibility,
                                    title: 'Total views',
                                    number: state.views.fold(
                                        0, (sum, item) => sum + item.views)),
                              );
                            } else {
                              return const Text("Something went wrong");
                            }
                          },
                        );
                      }
                      if (index == 2) {
                        return BlocBuilder<BookBloc, BookState>(
                          builder: (context, state) {
                            if (state is BookLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is BookLoaded) {
                              return TotalItems(
                                recentData: RecentData(
                                    icon: Icons.menu_book_sharp,
                                    title: 'Total books',
                                    number: state.books
                                        .where((book) => book.status == true)
                                        .length),
                              );
                            } else {
                              return const Text("Something went wrong");
                            }
                          },
                        );
                      }
                    }),
              ),
              DashBoardRow2()
            ],
          ),
        ),
      ),
    );
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
