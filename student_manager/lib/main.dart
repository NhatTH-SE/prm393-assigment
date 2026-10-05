import 'package:flutter/material.dart';
import 'services/student_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final service = StudentService();
    final data = service.getDisplayTexts();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Student Manager")),
        body: ListView(
          children: data.map((text) {
            return ListTile(title: Text(text));
          }).toList(),
        ),
      ),
    );
  }
}
