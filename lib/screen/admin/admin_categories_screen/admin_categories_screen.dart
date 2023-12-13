import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_categories_screen/component/category_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/custom_table_data.dart';
import '../dashboard/components/header.dart';
import '../../../model/admin_model.dart';
class AdminCategoriesScreen extends StatelessWidget {
  const AdminCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is CategoryLoaded) {
        return SafeArea(
            child: Drawer(
              backgroundColor: const Color(0xFF1B2063),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Header(
                      title: 'Categories',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 30, top: 20),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('New')),
                        ),
                      ],
                    ),
                    CategoryDataTable(
                      id: 'Cate ID',
                      name: 'Cate Name',
                      status: 'Status',
                      listCategories: state.categories,
                    )
                  ],
                ),
              ),
            ));
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}

