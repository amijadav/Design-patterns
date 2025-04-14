import 'dart:convert';

extension type RollNo(int value) {}
extension type Name(String value) {}

class StudentDataModel {
  final RollNo rollNo;
  final Name name;

  StudentDataModel({required this.rollNo, required this.name});

  StudentDataModel copyWith({RollNo? rollNo, Name? name}) => StudentDataModel(
        name: name ?? this.name,
        rollNo: rollNo ?? this.rollNo,
      );

  factory StudentDataModel.fromMap(Map<String, dynamic> map) =>
      StudentDataModel(
        name: map["name"],
        rollNo: map["rollNo"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "rollNo": rollNo,
      };

  factory StudentDataModel.fromJson(String value) =>
      StudentDataModel.fromMap(json.decode(value));

  String toJson() => json.encode(toMap());

  factory StudentDataModel.exampleModel() => StudentDataModel(
        rollNo: RollNo(15),
        name: Name("jack"),
      );
}
