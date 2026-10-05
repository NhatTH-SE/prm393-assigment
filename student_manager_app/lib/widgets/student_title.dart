import 'package:flutter/material.dart';
import 'package:student_manager_app/models/student.dart';

class StudentTitle extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;

  const StudentTitle({Key? key, required this.student, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      subtitle: Text('ID: ${student.id} | Tuổi: ${student.age}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
