import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.text,
    this.func,
  }) : super(key: key);

  final String? text;
  final Function()? func;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 15,
        ),
        shape: const StadiumBorder(),
      ),
      onPressed: func,
      child: Text(
        text!,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
