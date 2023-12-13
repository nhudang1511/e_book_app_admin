import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/models.dart';
import 'package:e_book_admin/repository/repositories.dart';
part 'category_event.dart';
part 'category_state.dart';
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository, super(CategoryLoading()){
    on<LoadCategory>(_onLoadCategory);
    on<UpdateCategory>(_onUpdateCategory);
  }
  void _onLoadCategory(event, Emitter emit) async {
    List<Category>? data = await _categoryRepository.getAllCategory();
    add(UpdateCategory(data!));
  }
  void _onUpdateCategory(event, Emitter emit) async {
    emit(CategoryLoaded(categories: event.categories));
  }
}