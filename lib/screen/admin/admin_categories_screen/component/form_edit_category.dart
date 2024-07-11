import 'package:e_book_admin/model/models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:e_book_admin/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormEditCategory extends StatefulWidget {
  final Category category;
  const FormEditCategory({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _FormEditCategoryState();
}

class _FormEditCategoryState extends State<FormEditCategory> {
  final editCategoryFormKey = GlobalKey<FormState>();
  late CategoryBloc categoryBloc;
  final TextEditingController nameController = TextEditingController();
  PlatformFile? _fileImage;

  Future<void> _pickFileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileImage = result.files.first;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of(context);
    nameController.text= widget.category.name;
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidthMini = MediaQuery.of(context).size.width * 0.25;

    return AlertDialog(
      title: const Text(
        'Edit Category',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidthMini,
        child: SingleChildScrollView(
          child: Form(
            key: editCategoryFormKey,
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
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration:
                  const InputDecoration(labelText: 'Category Name*'),
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
          onPressed: () {
            if (nameController.text == widget.category.name && _fileImage == null) {
                Navigator.of(context).pop();
            }
            else {
              categoryBloc.add(EditCategory(
                  widget.category.id, nameController.text, _fileImage));
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Edit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
