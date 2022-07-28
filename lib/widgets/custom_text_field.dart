import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.icon,
    this.isObscure = false,
    this.validator,
    this.type,
    this.name,
    this.onChanged,
  }) : super(key: key);

  final Icon? icon;
  final TextInputType? type;
  final bool isObscure;
  final String? name;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: FormBuilderTextField(
        keyboardType: type!,
        maxLines: 1,
        obscureText: isObscure,
        name: name!,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon!.icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
