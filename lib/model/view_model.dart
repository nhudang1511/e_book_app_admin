List<ViewModel> viewsFromJson(dynamic str) =>
    List<ViewModel>.from((str).map((x) => ViewModel.fromJson(x)));
class ViewModel {
  late String bookId;
  late int views;

  ViewModel(this.bookId, this.views);

  ViewModel.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    views = json['views'];
  }

}