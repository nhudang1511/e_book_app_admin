import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/items/items.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:e_book_admin/screen/admin/admin_contact_screen/component/form_send_notification.dart';
import 'package:e_book_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({
    super.key,
    required this.contact,
  });

  final ContactItem contact;

  @override
  State<StatefulWidget> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final ContactRepository _contactRepository = ContactRepository();
  late ContactBloc _contactBloc;

  @override
  void initState() {
    super.initState();
    _contactBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.5;
    return AlertDialog(
      title: const Text(
        'Question detail',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'email: ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    widget.contact.user.email,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // TextField cho Author
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: dialogWidth,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Content: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Expanded(child: Text(widget.contact.content)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final result = await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return FormSendNotification(uId: widget.contact.user.id);
              },
            );
            if (result == true) {
              final update =
                  await _contactRepository.updateContact(widget.contact.id);
              if (update == true) {
                _contactBloc.add(LoadContact());
                ShowSnackBar.success("Send notification successfully", context);
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text(
            'Send notification',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: const Text(
        //     'Send email',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        // button next
      ],
    );
  }
}
