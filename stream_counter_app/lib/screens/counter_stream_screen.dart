import 'package:flutter/material.dart';
import '../services/counter_stream_service.dart';

class CounterStreamScreen extends StatefulWidget {
  const CounterStreamScreen({super.key});

  @override
  State<CounterStreamScreen> createState() => _CounterStreamScreenState();
}

class _CounterStreamScreenState extends State<CounterStreamScreen> {
  late CounterStreamService _service;

  @override
  void initState() {
    super.initState();
    _service = CounterStreamService();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Product Price'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _service.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Có lỗi xảy ra: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  'Giá hiện tại: ${snapshot.data} VND',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _service.pause();
                  },
                  icon: const Icon(Icons.pause),
                  label: const Text("Pause"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    _service.resume();
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Resume"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
