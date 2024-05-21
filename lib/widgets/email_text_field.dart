import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/colors.dart';

Widget emailTextField(BuildContext context, TextEditingController controller, VoidCallback clearErrors) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: tdBGColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      controller: controller,
      onChanged: (value) {
        if (value.isNotEmpty) {
          clearErrors();
        }
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        prefixIcon: Icon(
          Icons.email,
          color: tdBlack,
          size: 20,
        ),
        border: InputBorder.none,
        hintText: 'Email',
        hintStyle: TextStyle(color: tdGrey),
        prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterYourEmail;
        }
        return null;
      },
    ),
  );
}



