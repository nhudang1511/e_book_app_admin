import 'package:e_book_admin/repository/repositories.dart';
import 'package:flutter/material.dart';

class FormSendNotification extends StatefulWidget {
  const FormSendNotification({
    super.key,
    required this.uId,
  });

  final String uId;

  @override
  State<StatefulWidget> createState() => _FormSendNotificationState();
}

class _FormSendNotificationState extends State<FormSendNotification> {
  final sendNotificationFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final NotificationRepository _notificationRepository =
      NotificationRepository();

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
            key: sendNotificationFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Title";
                    }
                    return null;
                  },
                ),
                // TextField cho Content
                TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Content";
                    }
                    return null;
                  },
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
          onPressed: () async {
            if (sendNotificationFormKey.currentState!.validate()) {
              var result = await _notificationRepository.sendNotification(
                  widget.uId, titleController.text, contentController.text);
              Navigator.of(context).pop(result); // Đóng Dialog
            }
          },
          child: const Text(
            'Send',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
