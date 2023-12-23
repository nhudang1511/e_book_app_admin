import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? successMessage;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    // this.validator,
    required this.onChanged,
    this.successMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autofocus: true,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter email";
            }
            return null;
          },
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF333333),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF8C2EEE),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(10),
          ),
          // validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}