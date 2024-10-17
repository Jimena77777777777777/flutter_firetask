import 'package:flutter/material.dart';
import '../general/colors.dart';

class TextFieldNormalWidget extends StatelessWidget {
  String hintText;
  IconData icon;
  Function? onTap;
  TextEditingController controller;

  TextFieldNormalWidget({
    required this.hintText,
    required this.icon,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onTap: onTap != null
            ? () {
                onTap!();
              }
            : null,
        readOnly: onTap != null ? true : false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          prefixIcon: Icon(
            icon,
            size: 20.0,
            color: kBrandPrimaryColor.withOpacity(0.6),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: kBrandPrimaryColor.withOpacity(0.6),
          ),
          filled: true,
          fillColor: kBrandSecondaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (String? value) {
          if (value != null && value.isEmpty) {
            return "Campo obligatorio";
          }
          return null;
        });
  }
}