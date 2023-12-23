import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/models.dart';
import 'package:e_book_admin/repository/repositories.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()) {
    on<LoadCategory>(_onLoadCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<AddCategory>(_onAddCategory);
    on<EditCategory>(_onEditCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  void _onLoadCategory(event, Emitter emit) async {
    List<Category>? data = await _categoryRepository.getAllCategory();
    add(UpdateCategory(data!));
  }

  void _onUpdateCategory(event, Emitter emit) async {
    emit(CategoryLoaded(categories: event.categories));
  }

  void _onAddCategory(event, Emitter emit) async {
    await _categoryRepository.addCategory(event.name, event.image);
    add(LoadCategory());
  }

  void _onEditCategory(event, Emitter emit) async {
    await _categoryRepository.updateCategory(event.categoryId, event.name, event.image);
    add(LoadCategory());
  }

  void _onDeleteCategory(event, Emitter emit) async {
    await _categoryRepository.deleteCategory(event.categoryId);
    add(LoadCategory());
  }
}
