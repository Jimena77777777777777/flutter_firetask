import 'package:flutter_firebase/ui/general/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCustomWidget extends StatelessWidget {
  String text;
  Color color;
  String icon;
  Function onPressed;

  ButtonCustomWidget({
    required this.text,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

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
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
        icon: SvgPicture.asset(
          'assets/icons/$icon.svg',
          color: Colors.white,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}