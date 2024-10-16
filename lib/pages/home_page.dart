import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Referencia a la colección 'tasks'
  CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  // Obtener documentos de la colección
                  QuerySnapshot querySnapshot = await tasksCollection.get();

                  if (querySnapshot.docs.isNotEmpty) {
                    // Crear una lista para almacenar los títulos y descripciones
                    List<String> taskData = [];

                    // Iterar sobre los documentos y agregar los datos a la lista
                    querySnapshot.docs.forEach((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      String title = data['title'] ?? 'Sin título';
                      String description =
                          data['description'] ?? 'Sin descripción';
                      taskData.add('Título: $title\nDescripción: $description');
                    });

                    // Mostrar los datos en un cuadro de diálogo o en la pantalla
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Registros obtenidos"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children:
                                  taskData.map((task) => Text(task)).toList(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cerrar"),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    print("No se encontraron documentos.");
                  }
                } catch (e) {
                  print("Error obteniendo los documentos: $e");
                }
              },
              child: Text("Obtener la data"),
            )
          ],
        ),
      ),
    );
  }
}
