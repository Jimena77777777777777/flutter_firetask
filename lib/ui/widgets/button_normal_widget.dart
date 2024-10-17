import 'package:flutter/material.dart';
import '../general/colors.dart';

class ButtonNormalWidget extends StatelessWidget {
  Function onPressed;

  ButtonNormalWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kBrandPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        icon: Icon(Icons.save),
        label: Text(
          "Guardar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}