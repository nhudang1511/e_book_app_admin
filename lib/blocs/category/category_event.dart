part of 'category_bloc.dart';

abstract class CategoryEvent {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategory extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCategory extends CategoryEvent {
  final List<Category> categories;

  const UpdateCategory(this.categories);

  @override
  List<Object?> get props => [];
}

class AddCategory extends CategoryEvent {
  final String name;
  final PlatformFile image;

  const AddCategory(this.name, this.image);

  @override
  List<Object?> get props => [];
}

class EditCategory extends CategoryEvent {
  final String categoryId;
  final String name;
  final PlatformFile? image;

  const EditCategory(this.categoryId, this.name, this.image);

  @override
  List<Object?> get props => [];
}

class DeleteCategory extends CategoryEvent {
  final String categoryId;

  const DeleteCategory(this.categoryId);

  @override
  List<Object?> get props => [];
}
