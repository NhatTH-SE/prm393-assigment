import '../models/student.dart';

void addStudent(List<Student> list, Student student) {
  list.add(student);
}

void updateGpa(
  List<Student> list,
  int studentId,
  double newGpa,
) {
  for (var student in list) {
    if (student.id == studentId) {
      student.gpa = newGpa;
      break;
    }
  }
}

List<Student> filterHighGpa(
  List<Student> list,
  double minGpa,
) {
  return list.where((s) => s.gpa >= minGpa).toList();
}

List<String> prepareDisplayData(
  List<Student> list,
  String Function(Student) formatter,
) {
  return list.map(formatter).toList();
}
