import 'package:flutter/material.dart';
import 'package:woke_out/components/text_field_container.dart';
import 'package:woke_out/constants.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
  });

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        key: widget.fieldKey,
        obscureText: _obscureText,
        maxLength: widget.maxLength ?? 20,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          counterText: "",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
