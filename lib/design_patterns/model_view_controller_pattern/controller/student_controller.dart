import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/student_data_model.dart';

abstract class StudentController implements ChangeNotifier {
  static StudentController? _instance;

  StudentDataModel get student;
  void updateStudentName(Name newName, {VoidCallback? onUpdate});
  factory StudentController() => _instance ??= _StudentControllerImpl();
}

class _StudentControllerImpl extends ChangeNotifier
    implements StudentController {
  StudentDataModel _student = StudentDataModel.exampleModel();

  @override
  StudentDataModel get student => _student;

  @override
  void updateStudentName(Name newName, {VoidCallback? onUpdate}) {
    _student = _student.copyWith(name: newName);
    notifyListeners();
  }
}
