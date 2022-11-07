import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({Key? key, this.hintText, this.onChanged, this.obscuretext=false})
      : super(key: key);

  final String? hintText;
  Function(String)? onChanged;
  bool? obscuretext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscuretext! ,
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
