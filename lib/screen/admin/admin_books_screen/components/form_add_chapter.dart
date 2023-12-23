import 'package:flutter/material.dart';

class FormAddChapter extends StatefulWidget {
  const FormAddChapter({super.key});

  @override
  State<StatefulWidget> createState() => _FormAddChapterState();
}

class _FormAddChapterState extends State<FormAddChapter> {
  final addChapterFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidthMini = MediaQuery.of(context).size.width * 0.25;

    return AlertDialog(
      title: const Text(
        'Add Chapter',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidthMini,
        child: SingleChildScrollView(
          child: Form(
            key: addChapterFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // TextField cho Content
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                    ),
                    child: TextFormField(
                      controller: contentController,
                      maxLines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Content";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Content*',
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
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
            if (addChapterFormKey.currentState!.validate()) {
                Navigator.of(context).pop({
                  'title': titleController.text,
                  'content': contentController.text,
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
