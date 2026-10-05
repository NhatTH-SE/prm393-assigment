import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onSelect;
  final VoidCallback onOpenDetail;
  final VoidCallback onDelete; // Thêm chức năng xóa item (Mở rộng)

  const StudentCard({
    super.key,
    required this.student,
    required this.onSelect,
    required this.onOpenDetail,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Yêu cầu mở rộng: Highlight item được chọn (Đổi màu nền)
      color: student.isSelected ? Colors.blue.shade50 : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onOpenDetail, // Tương tác: Mở màn hình chi tiết
        leading: CircleAvatar(
          child: Text(
            student.name.isNotEmpty ? student.name[0] : '?',
          ),
        ),
        title: Text(
          student.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          student.id,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                student.isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: student.isSelected ? Colors.green : Colors.grey,
              ),
              onPressed: onSelect, // Tương tác: Đổi trạng thái selected
              tooltip: 'Đánh dấu',
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete, // Tương tác: Xóa item (Mở rộng)
              tooltip: 'Xóa sinh viên',
            ),
          ],
        ),
      ),
    );
  }
}
