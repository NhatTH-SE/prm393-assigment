import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/student_card.dart';
import 'student_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Student> students = [
    Student(
      id: 'SV01',
      name: 'Nguyễn Văn A',
      email: 'a@student.edu',
      major: 'Computer Science',
    ),
    Student(
      id: 'SV02',
      name: 'Trần Thị B',
      email: 'b@student.edu',
      major: 'Information Systems',
    ),
    Student(
      id: 'SV03',
      name: 'Lê Văn C',
      email: 'c@student.edu',
      major: 'Software Engineering',
    ),
    Student(
      id: 'SV04',
      name: 'Phạm Văn D',
      email: 'd@student.edu',
      major: 'Data Science',
    ),
  ];

  void _toggleSelect(int index) {
    setState(() {
      students[index].isSelected = !students[index].isSelected;
    });
  }

  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  void _openDetail(Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentDetailScreen(student: student),
      ),
    ).then((_) {
      // Refresh UI in case state changed (though we are passing object ref)
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        centerTitle: true,
      ),
      body: students.isEmpty
          ? const Center(child: Text("Không có sinh viên nào."))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return StudentCard(
                  student: student,
                  onSelect: () => _toggleSelect(index),
                  onOpenDetail: () => _openDetail(student),
                  onDelete: () => _deleteStudent(index),
                );
              },
            ),
    );
  }
}
