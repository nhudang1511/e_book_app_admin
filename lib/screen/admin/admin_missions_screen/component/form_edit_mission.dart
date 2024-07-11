import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormEditMission extends StatefulWidget {
  const FormEditMission({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  State<StatefulWidget> createState() => _FormEditMissionState();
}

class _FormEditMissionState extends State<FormEditMission> {
  final editMissionFormKey = GlobalKey<FormState>();
  late MissionBloc missionBloc;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController coinsController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController timesController = TextEditingController();
  final SingleValueDropDownController typeController =
      SingleValueDropDownController();

  bool editButtonPressed = false;

  @override
  void initState() {
    super.initState();
    missionBloc = BlocProvider.of(context);
    editButtonPressed = false;
    nameController.text = widget.mission.name;
    coinsController.text = widget.mission.coins.toString();
    detailController.text = widget.mission.detail;
    timesController.text = widget.mission.times.toString();
    typeController.dropDownValue = DropDownValueModel(
        name: widget.mission.type, value: widget.mission.type);
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidthMini = MediaQuery.of(context).size.width * 0.25;

    return AlertDialog(
      title: const Text(
        'Edit Mission',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SizedBox(
        width: dialogWidthMini,
        child: SingleChildScrollView(
          child: Form(
            key: editMissionFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextField cho name
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name Mission";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // TextField cho coins
                TextFormField(
                  controller: coinsController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Coins Mission";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Coins*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // TextField cho detail
                TextFormField(
                  controller: detailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Detail Mission";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Detail*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // TextField cho type
                DropDownTextField(
                  controller: typeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Type Mission";
                    }
                    return null;
                  },
                  dropDownItemCount: 3,
                  dropDownList: const [
                    DropDownValueModel(name: 'Comment', value: "Comment"),
                    DropDownValueModel(name: 'Read', value: "Read"),
                    DropDownValueModel(name: 'coins', value: "coins"),
                  ],
                  onChanged: (val) {},
                ),
                // TextField cho times
                TextFormField(
                  controller: timesController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Times Mission";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Times*',
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.normal,
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
            if (editMissionFormKey.currentState!.validate()) {
              missionBloc.add(
                EditMission(
                  widget.mission.id,
                  nameController.text,
                  detailController.text,
                  typeController.dropDownValue!.name,
                  int.parse(coinsController.text),
                  int.parse(timesController.text),
                ),
              );
              Navigator.of(context).pop(nameController.text);
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
