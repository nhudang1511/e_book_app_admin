import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_audio.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_category.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_chapter.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormAddBook extends StatefulWidget {
  const FormAddBook({super.key});

  @override
  State<StatefulWidget> createState() => _FormAddBookState();
}

class _FormAddBookState extends State<FormAddBook> {
  late BookBloc bookBloc;

  int currentStep = 1;

  final addBookFormKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController chaptersController = TextEditingController();
  final TextEditingController audiosController = TextEditingController();
  final TextEditingController priceController = TextEditingController();


  late List<OptionCategory> listOptionCategories;
  late List<OptionCategory> selectedCategories = [];
  late Map<String, String> listChapters = {};
  late Map<String, dynamic> listAudios = {};

  late List<bool> addedChapters;
  late List<bool> addedAudios;

  int quantity = 0;
  int quantityAudios = 0;

  PlatformFile? _fileImage;
  PlatformFile? _fileBookReview1;
  PlatformFile? _fileBookReview2;

  late bool existCategory = false;
  late bool existChapters = false;
  late bool existAudios = false;
  late bool existFileImage = false;
  late bool existFileBookReview1 = false;
  late bool existFileBookReview2 = false;
  late bool addedAllChapters = true;
  late bool addedAllAudios = true;

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

  void incrementQuantityAudios() {
    setState(() {
      quantityAudios++;
      audiosController.text = quantityAudios.toString();
      if (quantityAudios != 0) {
        existAudios = false;
      }
    });
  }

  void decrementQuantityAudio() {
    if (quantityAudios > 0) {
      setState(() {
        quantityAudios--;
        audiosController.text = quantityAudios.toString();
        if (quantityAudios != 0) {
          existAudios = false;
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
    audiosController.text = quantityAudios.toString();
    bookBloc = BlocProvider.of(context);
    existCategory = false;
    existChapters = false;
    existAudios = false;
    existFileImage = false;
    existFileBookReview1 = false;
    existFileBookReview2 = false;
    addedAllChapters = true;
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.5;
    List<Widget> addChapters = [];
    List<Widget> addAudios = [];
    if (currentStep == 2) {
      for (int i = 1; i <= quantity; i++) {
        addChapters.add(
          Column(
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
                              barrierDismissible: false,
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
          ),
        );
      }
    }
    if (currentStep == 3) {
      for (int i = 1; i <= quantityAudios; i++) {
        addAudios.add(
          Column(
            children: [
              Row(
                children: [
                  Text("Chapter $i: "),
                  addedAudios[i - 1] == true
                      ? const Icon(Icons.check, color: Colors.green)
                      : ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic>? audioData =
                                await showDialog<Map<String, dynamic>>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const FormAddAudio();
                              },
                            );
                            setState(() {
                              if (audioData != null) {
                                String title = audioData['title'] ?? '';
                                PlatformFile? content = audioData['content'];
                                if (title == '') {
                                  listAudios['Chapter $i'] = content!;
                                } else {
                                  listAudios[
                                          'Chapter $i: ${title.toString()}'] =
                                      content!;
                                }
                                setState(() {
                                  addedAudios[i - 1] = true;
                                });
                              }
                            });
                          },
                          child: const Text(
                            '+ Add Audio',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
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
                  // TextField cho price
                  TextFormField(
                    controller: priceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Price";
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Price*',
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
                            child: Row(
                              children: [
                                Text(
                                  'Select Category*',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  // TextField cho Chapters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Chapters*: ',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                  existChapters == true && existAudios == true
                      ? const Text(
                          'Enter at least 1 audio or chapter field',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : const Text(''),
                  // Textfield cho audios
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Audios*: ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: decrementQuantityAudio,
                      ),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: TextFormField(
                          controller: audiosController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              quantityAudios = int.tryParse(value)!;
                              if (int.tryParse(value) != 0) {
                                existAudios = false;
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
                        onPressed: incrementQuantityAudios,
                      ),
                    ],
                  ),
                  existAudios == true && existChapters == true
                      ? const Text(
                          'Enter audios',
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
                      Text(
                        'Cover Image*: ',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                      Text(
                        'Book review*: ',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                              : Text(
                                  'Page 1: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
                              : Text(
                                  'Page 2: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
                addedAllChapters == false
                    ? const Text(
                        'Please add all chapters',
                        style: TextStyle(color: Colors.redAccent),
                      )
                    : const Text(''),
                if (currentStep == 3) ...addAudios,
                addedAllAudios == false
                    ? const Text(
                        'Please add all audios',
                        style: TextStyle(color: Colors.redAccent),
                      )
                    : const Text(''),
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
                  (quantity != 0 || quantityAudios != 0) &&
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
                    quantity != 0 ? quantity : quantityAudios,
                    countryController.text));
                setState(() {
                  if (quantity != 0) {
                    addedChapters = List.generate(quantity, (index) => false);
                    currentStep = 2;
                  } else {
                    addedAudios =
                        List.generate(quantityAudios, (index) => false);
                    currentStep = 3;
                  }
                });
              }
              if (selectedCategories.isEmpty) {
                setState(() {
                  existCategory = true;
                });
              }
              if (quantity == 0 && quantityAudios == 0) {
                setState(() {
                  existChapters = true;
                  existAudios = true;
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
          if (quantityAudios != 0) ...[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addedAudios = List.generate(quantityAudios, (index) => false);
                  currentStep = 3;
                }); // Đóng Dialog
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          if (quantityAudios == 0) ...[
            ElevatedButton(
              onPressed: () {
                if (listChapters.length == quantity) {
                  Navigator.of(context).pop({
                    'listChapters': listChapters,
                    'listAudios': listAudios,
                  });
                } else {
                  setState(() {
                    addedAllChapters = false;
                  });
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
        if (currentStep == 3) ...[
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Đóng Dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (listAudios.length == quantityAudios) {
                Navigator.of(context).pop({
                  'listChapters': listChapters,
                  'listAudios': listAudios,
                });
              } else {
                setState(() {
                  addedAllAudios = false;
                });
              }
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
