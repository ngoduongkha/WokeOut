import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;

  const EmailField({
    Key key,
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.onSaved,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _EmailField createState() => _EmailField();
}

class _EmailField extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      maxLength: widget.maxLength ?? 20,
      onSaved: widget.onSaved,
      autovalidateMode: AutovalidateMode.always,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: TextInputType.emailAddress,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "Please enter a valid email",
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: "",
      ),
    );
  }
}
