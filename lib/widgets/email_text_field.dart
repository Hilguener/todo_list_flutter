import 'package:flutter/material.dart';

import '../constants/colors.dart';

Widget emailTextField(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: tdBGColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      controller: controller,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.email,
            color: tdBlack,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: 'Email',
          hintStyle: TextStyle(color: tdGrey),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    ),
  );
}
