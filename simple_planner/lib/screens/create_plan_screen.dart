import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../widgets/primary_button.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      helpText: 'Select plan date',
    );
    if (picked == null) return;
    setState(() {
      _selectedDate = DateTime(picked.year, picked.month, picked.day);
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      helpText: 'Select plan time',
    );
    if (picked == null) return;
    setState(() {
      _selectedTime = picked;
    });
  }

  String _dateLabel() {
    if (_selectedDate == null) return 'Choose Date';
    final d = _selectedDate!;
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '\$y-\$m-\$day';
  }

  String _timeLabel() {
    if (_selectedTime == null) return 'Choose Time';
    final t = _selectedTime!;
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '\$hh:\$mm';
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();

    // Yêu cầu mở rộng: Validate date/time & Cải thiện UX
    if (title.isEmpty) {
      _showError('Vui lòng nhập tiêu đề!');
      return;
    }
    if (_selectedDate == null) {
      _showError('Vui lòng chọn ngày!');
      return;
    }
    if (_selectedTime == null) {
      _showError('Vui lòng chọn giờ!');
      return;
    }

    final plan = Plan(
      title: title,
      date: _selectedDate!,
      time: _selectedTime!,
    );

    // Yêu cầu mở rộng: Thêm màn hình Confirm (sử dụng Dialog cho UI nhất quán)
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận lưu'),
        content: Text('Bạn có chắc chắn muốn lưu kế hoạch "\$title" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Lưu'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      Navigator.pop(context, plan);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Plan Title',
                hintText: 'e.g. Study Flutter',
                prefixIcon: Icon(Icons.title),
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_dateLabel()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.access_time),
                    label: Text(_timeLabel()),
                  ),
                ),
              ],
            ),
            const Spacer(),
            PrimaryButton(
              text: 'Save',
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
