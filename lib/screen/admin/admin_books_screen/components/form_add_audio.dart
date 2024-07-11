import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FormAddAudio extends StatefulWidget {
  const FormAddAudio({super.key});

  @override
  State<StatefulWidget> createState() => _FormAddAudioState();
}

class _FormAddAudioState extends State<FormAddAudio> {
  final addAudioFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  PlatformFile? _fileAudio;
  bool audioSelected = false;
  late bool existAudio = false;

  Future<void> _pickFileAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      setState(() {
        _fileAudio = result.files.first;
        audioSelected = true;
        existAudio = false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidthMini = MediaQuery.of(context).size.width * 0.25;

    return AlertDialog(
      title: const Text(
        'Add Audio',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidthMini,
        child: SingleChildScrollView(
          child: Form(
            key: addAudioFormKey,
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
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Audio*: ',
                          style: TextStyle(color: Colors.white60),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _fileAudio != null
                                ? Text(
                              '${_fileAudio!.name}  ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                                : const Text(''),
                            ElevatedButton(
                              onPressed: _pickFileAudio,
                              child: const Text(
                                'select file',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        existAudio == true
                            ? const Text(
                          'Select audio',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                            : const Text(''),
                      ],
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
            if (addAudioFormKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'title': titleController.text,
                'content': _fileAudio,
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
