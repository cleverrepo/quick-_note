import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  const customTextFormField({
    super.key, this.lable, required this.validator, this.obsecure,
  });
final lable;
final String? Function (String?) validator;
final obsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obsecure,
      decoration: InputDecoration(
        label: Text(lable),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              )
          )
      ),
    );
  }
}