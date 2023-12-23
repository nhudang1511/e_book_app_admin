import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_category.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_chapter.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormEditBook extends StatefulWidget {
  const FormEditBook({super.key});

  @override
  State<StatefulWidget> createState() => _FormEditBookState();
}

class _FormEditBookState extends State<FormEditBook> {
  late BookBloc bookBloc;

  int currentStep = 1;

  final addBookFormKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController chaptersController = TextEditingController();

  late List<OptionCategory> listOptionCategories;
  late List<OptionCategory> selectedCategories = [];
  late Map<String, String> listChapters = {};
  late List<bool> addedChapters;

  int quantity = 0;

  PlatformFile? _fileImage;
  PlatformFile? _fileBookReview1;
  PlatformFile? _fileBookReview2;

  late bool existCategory = false;
  late bool existChapters = false;
  late bool existFileImage = false;
  late bool existFileBookReview1 = false;
  late bool existFileBookReview2 = false;

  Future<void> _pickFileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _fileImage = result.files.first;
        existFileImage = false;
      });
    }
  }

  Future<void> _pickBookReview1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _fileBookReview1 = result.files.first;
        existFileBookReview1 = false;
      });
    }
  }

  Future<void> _pickBookReview2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _fileBookReview2 = result.files.first;
        existFileBookReview2 = false;
      });
    }
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      chaptersController.text = quantity.toString();
      if (quantity != 0) {
        existChapters = false;
      }
    });
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        chaptersController.text = quantity.toString();
        if (quantity != 0) {
          existChapters = false;
        }
      });
    }
  }

  List<OptionCategory> mapListCategories(
      List<Category> categories, List<OptionCategory> selected) {
    List<OptionCategory> listOptionCategories = categories.map((category) {
      bool? check =
          selected.where((element) => element.idCate == category.id).isEmpty;
      if (check != true) {
        return OptionCategory(category.id, category.name, true);
      }
      return OptionCategory(category.id, category.name, false);
    }).toList();
    return listOptionCategories;
  }

  @override
  void initState() {
    super.initState();
    chaptersController.text = quantity.toString();
    bookBloc = BlocProvider.of(context);
    existCategory = false;
    existChapters = false;
    existFileImage = false;
    existFileBookReview1 = false;
    existFileBookReview2 = false;
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.5;
    List<Widget> addChapters = [];
    if (currentStep == 2) {
      for (int i = 1; i <= quantity; i++) {
        addChapters.add(Column(
          children: [
            Row(
              children: [
                Text("Chapter $i: "),
                addedChapters[i - 1] == true
                    ? const Icon(Icons.check, color: Colors.green)
                    : ElevatedButton(
                  onPressed: () async {
                    Map<String, String>? chapterData =
                    await showDialog<Map<String, String>>(
                      context: context,
                      builder: (BuildContext context) {
                        return const FormAddChapter();
                      },
                    );
                    setState(() {
                      if (chapterData != null) {
                        String title = chapterData['title'] ?? '';
                        String content = chapterData['content'] ?? '';
                        if (title == '') {
                          listChapters['Chapter $i'] = content;
                        } else {
                          listChapters['Chapter $i: $title'] = content;
                        }
                        setState(() {
                          addedChapters[i - 1] = true;
                        });
                      }
                    });
                  },
                  child: const Text(
                    '+ Add Chapter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ));
      }
    }

    return AlertDialog(
      title: const Text(
        'Add Book',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Form(
            key: addBookFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentStep == 1) ...[
                  // TextField cho Title
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Title";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Title*',
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // TextField cho Author
                  TextFormField(
                    controller: authorController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Author";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Author*',
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // TextField cho Description
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Description";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Description*',
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // TextField cho Language
                  TextFormField(
                    controller: languageController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Language";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Language*',
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // TextField cho Country
                  TextFormField(
                    controller: countryController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Country";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Country*',
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // DropdownButton cho Category ID
                  Row(
                    children: [
                      BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return const CircularProgressIndicator();
                            }
                            if (state is CategoryLoaded) {
                              listOptionCategories = mapListCategories(
                                  state.categories
                                      .where((book) => book.status == true)
                                      .toList(),
                                  selectedCategories);
                              return PopupMenuButton<String>(
                                child: const Row(
                                  children: [
                                    Text('Select Category*',
                                        style: TextStyle(color: Colors.white60)),
                                    // Thay thế bằng text mong muốn
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                itemBuilder: (BuildContext context) {
                                  return List.generate(
                                    listOptionCategories.length,
                                        (index) {
                                      final item = listOptionCategories[index];
                                      return CheckedPopupMenuItem<String>(
                                        value: item.idCate,
                                        checked: item.isChecked,
                                        child: ListTile(
                                          title: Text(item.name),
                                        ),
                                      );
                                    },
                                  );
                                },
                                onSelected: (String selectedValue) {
                                  setState(() {
                                    for (var category in listOptionCategories) {
                                      if (category.idCate == selectedValue) {
                                        if (category.isChecked) {
                                          selectedCategories.removeWhere(
                                                  (category) =>
                                              category.idCate == selectedValue);
                                        } else {
                                          selectedCategories.add(category);
                                        }
                                        category.isChecked = !category.isChecked;
                                        if (selectedCategories.isNotEmpty) {
                                          existCategory = false;
                                        }
                                      }
                                    }
                                  });
                                },
                              );
                            } else {
                              return const Text("Something went wrong");
                            }
                          }),
                      ElevatedButton(
                        onPressed: () async {
                          await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return const FormAddCategory();
                            },
                          );
                          setState(() {});
                        },
                        child: const Text(
                          '+ New Category',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  existCategory == true
                      ? const Text(
                    'Select category',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                      : const Text(''),
                  // TextField cho Chapters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Chapters*: ',
                        style: TextStyle(color: Colors.white60),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: decrementQuantity,
                      ),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: TextFormField(
                          controller: chaptersController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              quantity = int.tryParse(value)!;
                              if (int.tryParse(value) != 0) {
                                existChapters = false;
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        onPressed: incrementQuantity,
                      ),
                    ],
                  ),
                  existChapters == true
                      ? const Text(
                    'Enter chapters',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                      : const Text(''),
                  // TextField cho Image URL
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cover Image*: ',
                        style: TextStyle(color: Colors.white60),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _fileImage != null
                              ? Text(
                            '${_fileImage!.name}  ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                              : const Text(''),
                          ElevatedButton(
                            onPressed: _pickFileImage,
                            child: const Text(
                              'select file',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  existFileImage == true
                      ? const Text(
                    'Select image cover',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                      : const Text(''),
                  // TextField cho Book Preview
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Book review*: ',
                        style: TextStyle(color: Colors.white60),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _fileBookReview1 != null
                              ? Text(
                            'Page 1: ${_fileBookReview1!.name}  ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                              : const Text(
                            'Page 1: ',
                            style: TextStyle(color: Colors.white60),
                          ),
                          ElevatedButton(
                            onPressed: _pickBookReview1,
                            child: const Text(
                              'select file',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      existFileBookReview1 == true
                          ? const Text(
                        'Select image',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                          : Container(
                        height: 8,
                      ),
                      Row(
                        children: [
                          _fileBookReview2 != null
                              ? Text(
                            'Page 2: ${_fileBookReview2!.name}  ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                              : const Text(
                            'Page 2: ',
                            style: TextStyle(color: Colors.white60),
                          ),
                          ElevatedButton(
                            onPressed: _pickBookReview2,
                            child: const Text(
                              'select file',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      existFileBookReview2 == true
                          ? const Text(
                        'Select image',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                          : Container(
                        height: 0,
                      ),
                    ],
                  ),
                ],
                if (currentStep == 2) ...addChapters,
              ],
            ),
          ),
        ),
      ),
      actions: [
        if (currentStep == 1) ...[
          // Button to move to step 2
          // button cancel
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng Dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // button next
          ElevatedButton(
            onPressed: () async {
              if (addBookFormKey.currentState!.validate() &&
                  selectedCategories.isNotEmpty &&
                  quantity != 0 &&
                  _fileImage != null &&
                  _fileBookReview1 != null &&
                  _fileBookReview2 != null) {
                bookBloc.add(AddBook(
                    authorController.text,
                    selectedCategories.map((e) => e.idCate).toList(),
                    descriptionController.text,
                    _fileImage!,
                    languageController.text,
                    titleController.text,
                    [_fileBookReview1!, _fileBookReview2!],
                    quantity,
                    countryController.text));
                setState(() {
                  addedChapters = List.generate(quantity, (index) => false);
                  currentStep = 2;
                });
              }
              if (selectedCategories.isEmpty) {
                setState(() {
                  existCategory = true;
                });
              }
              if (quantity == 0) {
                setState(() {
                  existChapters = true;
                });
              }
              if (_fileImage == null) {
                setState(() {
                  existFileImage = true;
                });
              }
              if (_fileBookReview1 == null) {
                setState(() {
                  existFileBookReview1 = true;
                });
              }
              if (_fileBookReview2 == null) {
                setState(() {
                  existFileBookReview2 = true;
                });
              }
            },
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        if (currentStep == 2) ...[
          // button cancel
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Đóng Dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // button next
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(listChapters);
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ],
    );
  }
}

class OptionCategory {
  final String idCate;
  final String name;
  late bool isChecked;

  OptionCategory(this.idCate, this.name, this.isChecked);
}
