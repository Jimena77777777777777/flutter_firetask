import 'package:flutter_firebase/models/task_model.dart';
import 'package:flutter_firebase/services/my_service_firestore.dart';
import 'package:flutter_firebase/ui/widgets/textfield_normal_widget.dart';
import 'package:flutter/material.dart';
import '../general/colors.dart';
import 'button_normal_widget.dart';
import 'general_widgets.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({Key? key}) : super(key: key);

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final formKey = GlobalKey<FormState>();
  MyServiceFirestore taskService = MyServiceFirestore(collection: "tasks");
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String categorySelected = "Personal";

  showSelectDate() async {
    DateTime? datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Seleccionar fecha",
      builder: (BuildContext context, Widget? widget) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              elevation: 0,
              backgroundColor: kBrandSecondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            colorScheme: ColorScheme.dark(),
            primaryColor: kBrandPrimaryColor,
          ),
          child: widget!,
        );
      },
    );

    if (datetime != null) {
      _dateController.text = datetime.toString().substring(0, 10);
      setState(() {});
    }
  }

  registerTask() {
    if (formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        title: _titleController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        category: categorySelected,
        status: true,
      );
      taskService.addTask(taskModel).then((value) {
        if (value.isNotEmpty) {
          Navigator.pop(context);
          showSnackBarSuccess(context, "La tarea fue registrada con éxito.");
        }
      }).catchError((error) {
        showSnackBarError(
            context, "Hubo un inconveniente, inténtalo nuevamente");
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.0), topRight: Radius.circular(22.0))),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Agregar tarea",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
            divider10(),
            TextFieldNormalWidget(
              hintText: "Título",
              icon: Icons.text_fields,
              controller: _titleController,
            ),
            divider10(),
            TextFieldNormalWidget(
              hintText: "Descripción",
              icon: Icons.description,
              controller: _descriptionController,
            ),
            divider10(),
            const Text("Categorías: "),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 10.0,
              children: [
                FilterChip(
                  selected: categorySelected == "Personal",
                  backgroundColor: kBrandSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  selectedColor: categoryColor[categorySelected],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categorySelected == "Personal"
                        ? Colors.white
                        : kBrandPrimaryColor,
                  ),
                  label: Text("Personal"),
                  onSelected: (bool value) {
                    categorySelected = "Personal";
                    setState(() {});
                  },
                ),
                FilterChip(
                  selected: categorySelected == "Trabajo",
                  backgroundColor: kBrandSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  selectedColor: categoryColor[categorySelected],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categorySelected == "Trabajo"
                        ? Colors.white
                        : kBrandPrimaryColor,
                  ),
                  label: Text("Trabajo"),
                  onSelected: (bool value) {
                    categorySelected = "Trabajo";
                    setState(() {});
                  },
                ),
                FilterChip(
                  selected: categorySelected == "Otro",
                  backgroundColor: kBrandSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  selectedColor: categoryColor[categorySelected],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categorySelected == "Otro"
                        ? Colors.white
                        : kBrandPrimaryColor,
                  ),
                  label: Text("Otro"),
                  onSelected: (bool value) {
                    categorySelected = "Otro";
                    setState(() {});
                  },
                ),
              ],
            ),
            divider10(),
            TextFieldNormalWidget(
              hintText: "Fecha",
              icon: Icons.date_range,
              controller: _dateController,
              onTap: () {
                showSelectDate();
              },
            ),
            divider20(),
            ButtonNormalWidget(
              onPressed: () {
                registerTask();
              },
            ),
          ],
        ),
      ),
    );
  }
}