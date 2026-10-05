import '../models/student.dart';

class StudentService {
  List<Student> students = [
    Student("An", 3.6),
    Student("Binh", 3.8),
    Student("Dung", 3.4),
  ];

  List<Student> getExcellentStudents() {
    return students.where((s) => s.gpa >= 3.6).toList();
  }

  List<String> getDisplayTexts() {
    return getExcellentStudents().map((s) => s.display()).toList();
  }
}
