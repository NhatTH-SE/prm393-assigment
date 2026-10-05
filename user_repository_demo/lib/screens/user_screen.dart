import 'package:flutter/material.dart';
import '../data/repositories/user_repository.dart';
import '../models/user.dart';

class UserScreen extends StatefulWidget {
  final UserRepository repository;
  
  const UserScreen({super.key, required this.repository});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = widget.repository.getUsers();
  }

  void _refreshData() {
    setState(() {
      _usersFuture = widget.repository.getUsers(forceRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List (Repository Pattern)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Force Refresh (Call API)',
          )
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(users[index].name),
                subtitle: Text('ID: ${users[index].id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lấy lại dữ liệu bình thường (sẽ lấy từ cache nếu có)
          setState(() {
            _usersFuture = widget.repository.getUsers();
          });
        },
        tooltip: 'Load Data (Sẽ lấy Cache nếu có)',
        child: const Icon(Icons.download),
      ),
    );
  }
}
