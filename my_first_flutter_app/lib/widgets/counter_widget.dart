import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: const Text('Increase'),
        ),
        const SizedBox(height: 10), // Thêm khoảng cách giữa 2 nút
        ElevatedButton(
          onPressed: () {
            setState(() {
              count = 0; // Đặt lại biến count về 0
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.redAccent, // Đổi màu để phân biệt với nút Increase
            foregroundColor: Colors.white,
          ),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
