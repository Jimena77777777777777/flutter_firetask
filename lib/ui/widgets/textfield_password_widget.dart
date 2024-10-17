import 'package:flutter/material.dart';
import '../general/colors.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  TextEditingController controller;
  TextFieldPasswordWidget({
    required this.controller,
  });

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        obscureText: isInvisible,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          prefixIcon: Icon(
            Icons.lock,
            size: 20.0,
            color: kBrandPrimaryColor.withOpacity(0.6),
          ),
          suffixIcon: IconButton(
            icon: Icon(
                isInvisible
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
                color: kBrandPrimaryColor.withOpacity(0.60)),
            onPressed: () {
              isInvisible = !isInvisible;
              setState(() {});
            },
          ),
          hintText: "Contraseña",
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