
import 'package:flutter/material.dart';
import '../general/colors.dart';

class ButtonNormalWidget extends StatelessWidget {

  Function onPressed;

  ButtonNormalWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),

          ),
        ),
        onPressed: (){
          onPressed();

        },
        icon: Icon(Icons.save, color: Colors.white24,),
        label: Text("Guardar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),),
      ),
    );
  }
}
