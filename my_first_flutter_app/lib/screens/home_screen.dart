import 'package:flutter/material.dart';

import '../widgets/profile_card.dart';
import '../widgets/counter_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My First Flutter App')),
      // Bọc Column trong SizedBox.expand hoặc Center để Column ra giữa màn hình đẹp hơn
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Truyền dữ liệu vào ProfileCard
            ProfileCard(
              name: 'Trần Hoàng Nhật',
              role: 'Flutter Beginner',
              themeColor: Colors.blue,
            ),
            SizedBox(height: 20),
            CounterWidget(),
          ],
        ),
      ),
    );
  }
}
