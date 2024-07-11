import 'package:flutter/material.dart';
import 'package:e_book_admin/model/models.dart';

class MissionDetail extends StatefulWidget {
  const MissionDetail({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  State<StatefulWidget> createState() => _MissionDetailState();
}

class _MissionDetailState extends State<MissionDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width * 0.5;
    return AlertDialog(
      title: const Text(
        'Mission detail',
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
                    'Name: ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    widget.mission.name,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // TextField cho Author
              Row(
                children: [
                  Text(
                    'Author: ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(widget.mission.coins.toString()),
                ],
              ),
              const SizedBox(height: 8),

              // TextField cho Description
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: dialogWidth,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail: ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Expanded(
                      child: Text(widget.mission.detail),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // TextField cho Language
              Row(
                children: [
                  Text(
                    'Type: ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(widget.mission.type),
                ],
              ),
              const SizedBox(height: 8),

              // TextField cho Language
              Row(
                children: [
                  Text(
                    'Times: ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    widget.mission.times.toString(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng Dialog
          },
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // button next
      ],
    );
  }
}
