import 'package:design_patterns/design_patterns/model_view_controller_pattern/model/student_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/student_controller.dart';

class ModelViewControllerPatternExample extends StatelessWidget {
  ModelViewControllerPatternExample({super.key});

  final StudentController controller = StudentController();

  void onUpdateNamePressed() {
    controller.updateStudentName(Name("Harry"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StudentController>(
          builder: (context, controller, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Student:",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text("Name: ${controller.student.name}",
                    style: const TextStyle(fontSize: 18)),
                Text("Roll No: ${controller.student.rollNo}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onUpdateNamePressed,
                  child: const Text("Update Name"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
