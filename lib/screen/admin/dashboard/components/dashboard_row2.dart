import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../config/responsive.dart';

class DashBoardRow2 extends StatelessWidget {
  DashBoardRow2({
    super.key,
  });

  String shortenText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      int endIndex =
          maxLength - 3; // Giảm ba ký tự để có chỗ cho dấu chấm ba chấm
      while (endIndex > 0 && text[endIndex] != ' ') {
        endIndex--;
      }
      return '${text.substring(0, endIndex)}...';
    }
  }

  List<ChartData> chartData(List<ViewModel> listView, List<Book> listBook) {
    listView.sort((a, b) => b.views.compareTo(a.views));
    List<ViewModel> topValues;
    if (listView.length >= 5) {
      topValues = listView.sublist(0, 5);
    } else {
      topValues = listView;
    }
    List<ChartData> chartData = [];
    for (var views in topValues) {
      Book? book = listBook.firstWhere((book) => book.id == views.bookId);
      chartData.add(ChartData(book.title, views.views));
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return (!Responsive.isMobile(context))
        ? Row(
            children: [
              Expanded(
                flex: 2,
                child: BlocBuilder<ViewBloc, ViewState>(
                  builder: (context, state) {
                    if (state is ViewLoading) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    if (state is ViewLoaded) {
                      List<ViewModel> listViews = state.views;
                      return BlocBuilder<BookBloc, BookState>(
                          builder: (context, state) {
                        if (state is BookLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is BookLoaded) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            margin: const EdgeInsets.all(10),
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                labelStyle: const TextStyle(
                                    color: Colors.black), // Màu chữ trục x
                              ),
                              primaryYAxis: NumericAxis(
                                labelStyle: const TextStyle(
                                    color: Colors.black), // Màu chữ trục y
                              ),
                              series: <ChartSeries>[
                                StackedColumnSeries<ChartData, String>(
                                    dataSource:
                                        chartData(listViews, state.books),
                                    xValueMapper: (ChartData data, _) =>
                                        shortenText(data.x, 25),
                                    yValueMapper: (ChartData data, _) => data.y,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ],
                            ),
                          );
                        } else {
                          return const Text("Something went wrong");
                        }
                      });
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFFDC844),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: BlocBuilder<ViewBloc, ViewState>(
                    builder: (context, state) {
                      if (state is ViewLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      if (state is ViewLoaded) {
                        ViewModel topBook = state.views.reduce((max, current) =>
                            current.views > max.views ? current : max);
                        return BlocBuilder<BookBloc, BookState>(
                            builder: (context, state) {
                          if (state is BookLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is BookLoaded) {
                            Book? book = state.books.firstWhere(
                              (book) => book.id == topBook.bookId,
                            );
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Top view',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Image.network(
                                  book.imageUrl,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                ),
                                Text(
                                  book.title,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            );
                          } else {
                            return const Text("Something went wrong");
                          }
                        });
                      } else {
                        return const Text("Something went wrong");
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFDC844),
                ),
                margin: const EdgeInsets.all(10),
                child: BlocBuilder<ViewBloc, ViewState>(
                  builder: (context, state) {
                    if (state is ViewLoading) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    if (state is ViewLoaded) {
                      ViewModel topBook = state.views.reduce((max, current) =>
                          current.views > max.views ? current : max);
                      return BlocBuilder<BookBloc, BookState>(
                          builder: (context, state) {
                        if (state is BookLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is BookLoaded) {
                          Book? book = state.books.firstWhere(
                            (book) => book.id == topBook.bookId,
                          );
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Top view',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Image.network(
                                book.imageUrl,
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              Text(
                                book.title,
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            ],
                          );
                        } else {
                          return const Text("Something went wrong");
                        }
                      });
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(10),
                child: SfCartesianChart(),
              ),
            ],
          );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int y;
}
