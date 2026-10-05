import 'package:flutter/material.dart';
import '../services/counter_stream_service.dart';

class ReactiveScreen extends StatefulWidget {
  const ReactiveScreen({super.key});

  @override
  State<ReactiveScreen> createState() => _ReactiveScreenState();
}

class _ReactiveScreenState extends State<ReactiveScreen> {
  late ReactiveCounterService _service;

  @override
  void initState() {
    super.initState();
    _service = ReactiveCounterService();
    _service.start();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('UI build (không bị gọi lại khi Stream có data mới)');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive UI Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Yêu cầu mở rộng: Stream 2 (Message Stream)
            StreamBuilder<String>(
              stream: _service.messageStream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? "Đang chờ thông báo...",
                  style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                );
              },
            ),
            const SizedBox(height: 20),

            // Stream 1 (Widget A lắng nghe)
            StreamBuilder<int>(
              stream: _service.counterStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Waiting...');
                return Text(
                  'Counter (Số): ${snapshot.data}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),

            // Yêu cầu mở rộng: Widget B cùng lắng nghe chung 1 Stream 1
            StreamBuilder<int>(
              stream: _service.counterStream,
              builder: (context, snapshot) {
                final value = snapshot.data ?? 0;
                return CircularProgressIndicator(
                  value: (value % 10) / 10, // Thanh tiến trình chạy theo chu kỳ 10 giây
                );
              },
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _service.pause(),
                  child: const Text('Pause'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _service.resume(),
                  child: const Text('Resume'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
