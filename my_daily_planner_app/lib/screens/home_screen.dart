import 'package:flutter/material.dart';

import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dữ liệu sẽ nằm ở đây (Bước 6)
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    // Giao diện sẽ nằm ở đây (Bước 5)
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Daily Planer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tasks.map((task) {
            return TaskItem(title: task);
          }).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            tasks.add('Task thứ ${tasks.length + 1}');
          });
        },
        tooltip: 'Thêm công việc',
        child: const Icon(Icons.add),
      ),
    );
  }
}
