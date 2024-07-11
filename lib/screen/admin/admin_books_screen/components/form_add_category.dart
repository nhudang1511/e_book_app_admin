import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:e_book_admin/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormAddCategory extends StatefulWidget {
  const FormAddCategory({super.key});

  @override
  State<StatefulWidget> createState() => _FormAddCategoryState();
}

class _FormAddCategoryState extends State<FormAddCategory> {
  final addCategoryFormKey = GlobalKey<FormState>();
  late CategoryBloc categoryBloc;
  final TextEditingController nameController = TextEditingController();
  PlatformFile? _fileImage;
  bool imageSelected = false;
  bool addButtonPressed = false;
  late bool existImage = false;

  Future<void> _pickFileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _fileImage = result.files.first;
        imageSelected = true;
        existImage = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of(context);
    imageSelected = false;
    addButtonPressed = false;
    existImage = false;
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidthMini = MediaQuery.of(context).size.width * 0.25;

    return AlertDialog(
      title: const Text(
        'Add Category',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidthMini,
        child: SingleChildScrollView(
          child: Form(
            key: addCategoryFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextField cho Title
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name Category";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category Name*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // TextField cho Image URL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Image*: ',
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
                    existImage == true
                        ? const Text(
                            'Select image',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : const Text(''),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
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
            if (addCategoryFormKey.currentState!.validate()) {
              if (_fileImage != null) {
                categoryBloc.add(AddCategory(nameController.text, _fileImage!));
                Navigator.of(context).pop();
              } else {
                setState(() {
                  existImage = true;
                });
              }
            } else if (_fileImage == null) {
              setState(() {
                existImage = true;
              });
            }
          },
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
