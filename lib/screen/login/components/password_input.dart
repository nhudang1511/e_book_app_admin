import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? successMessage;

  const PasswordInput(
      {required this.hint,
      super.key,
      required this.controller,
      this.successMessage,
      required this.onChanged});

  @override
  State<StatefulWidget> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        controller: widget.controller,
        obscureText: _passwordVisible,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(10),
          hintText: widget.hint,
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
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Password";
          }
        },
        onChanged: widget.onChanged,
      ),
    ]);
  }
}
