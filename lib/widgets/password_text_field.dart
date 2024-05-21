import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/colors.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback clearErrors;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.clearErrors,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: tdBGColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            onChanged: (_) {
              widget.clearErrors();
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: tdBlack,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: tdBlack,
                ),
                onPressed: _togglePasswordVisibility,
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: tdGrey),
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 20, minWidth: 25),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.pleaseEnterYourPassword;
              }
              if (value.length < 6) {
                return AppLocalizations.of(context)!.passwordMustBeAtLeast;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
