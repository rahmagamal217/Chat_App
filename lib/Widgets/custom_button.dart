import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.onTap, required this.text}) : super(key: key);
  VoidCallback? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
