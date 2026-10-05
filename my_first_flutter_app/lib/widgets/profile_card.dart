import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  // 1. Khai báo các biến nhận dữ liệu
  final String name;
  final String role;
  final Color themeColor;

  // 2. Cập nhật constructor
  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    this.themeColor = Colors.blue, // Màu mặc định nếu không truyền
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: themeColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: themeColor.withOpacity(0.3), width: 1),
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Giúp Card bọc vừa đủ nội dung
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: themeColor.withOpacity(0.2), // Áp dụng theme màu
              child: Icon(Icons.person, size: 40, color: themeColor),
            ),
            const SizedBox(height: 10),
            Text(
              name, // Hiển thị tên từ constructor
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor, // Áp dụng theme màu cho chữ
              ),
            ),
            const SizedBox(height: 4),
            Text(
              role, // Hiển thị chức danh từ constructor
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
