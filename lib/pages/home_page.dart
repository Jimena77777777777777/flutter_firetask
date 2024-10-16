import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
const HomePage({Key? key}): super(key: key);
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Firebase Firuwuwuestore"),
),

body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center ,
    children: [
      ElevatedButton(
        onPressed: (){}, 
        child: Text("Obtener la data")
      )
    ],
  ),
),

);
}
}