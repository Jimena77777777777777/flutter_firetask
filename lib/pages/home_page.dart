import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {

CollectionReference tasksReference = FirebaseFirestore.instance.collection('tasks');


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
        
        onPressed: (){
          tasksReference.get().then((QuerySnapshot value){
            
            QuerySnapshot collection = value;
            collection.docs.forEach((QueryDocumentSnapshot element){
              Map <String, dynamic> myMap=element.data() as Map<String, dynamic>;
              print(myMap["title"]);
            }
            );
          });
        }, 

        child: Text("Obtener la data")
      ),
    
      ElevatedButton(onPressed: (){

        tasksReference .add(
          {
            "title":"Ir a comprar mangas puercos 2",
            "description": "comprar coca cola"  

          },
          ).then(( DocumentReference value){
            print(value.id);
          }).catchError((error){
            print("Ocurrio un error en el registro");
          }).whenComplete((){
            print("El registro ah terminado ");
          });

      },
       child: Text("Agregar documento",
       
       ),
       ),
    
      ElevatedButton(onPressed: (){

      }, 
      
      child: Text("Actualizar documento",
      ),
      ),
    ],
  ),
),

);
}
}