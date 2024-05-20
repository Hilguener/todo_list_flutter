import 'package:flutter/material.dart';

import '../constants/colors.dart';

Widget passwordTextField(TextEditingController controller, String hintText) {
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
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: const Icon(
              Icons.lock,
              color: tdBlack,
              size: 20,
            ),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(color: tdGrey),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 20, minWidth: 25),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ),
    ],
  );
}
