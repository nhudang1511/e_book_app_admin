import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_categories_screen/component/category_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/header.dart';

class AdminCategoriesScreen extends StatefulWidget {
  const AdminCategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is CategoryLoaded) {
        return SafeArea(
          child: Drawer(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Header(
                    title: 'Categories',
                  ),
                  CategoryDataTable(
                    id: 'Category ID',
                    name: 'Category Name',
                    listCategories: (state.categories
                        .where((model) => model.status == true)
                        .toList()
                      ..sort((a, b) => a.name.compareTo(b.name))),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}
