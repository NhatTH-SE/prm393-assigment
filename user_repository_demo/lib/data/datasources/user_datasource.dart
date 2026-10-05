import '../../models/user.dart';

// Interface
abstract class UserDataSource {
  Future<List<User>> getUsers();
  Future<void> saveUsers(List<User> users);
}

// 1. API DataSource (Mô phỏng API)
class UserApiDataSource implements UserDataSource {
  @override
  Future<List<User>> getUsers() async {
    print('--> [API] Đang fetch dữ liệu từ Internet...');
    await Future.delayed(const Duration(seconds: 2)); // Giả lập mạng chậm
    return [
      User(id: 1, name: 'Alice (from API)'),
      User(id: 2, name: 'Bob (from API)'),
      User(id: 3, name: 'Charlie (from API)'),
    ];
  }

  @override
  Future<void> saveUsers(List<User> users) async {
    // API thường không save kiểu này (chỉ fetch)
  }
}

// 2. Local DataSource (Mô phỏng Cache/Database)
class UserLocalDataSource implements UserDataSource {
  List<User> _localCache = [];

  @override
  Future<List<User>> getUsers() async {
    print('--> [Local] Đang đọc từ Local Cache...');
    await Future.delayed(const Duration(milliseconds: 500));
    return _localCache;
  }

  @override
  Future<void> saveUsers(List<User> users) async {
    print('--> [Local] Đang lưu vào Local Cache...');
    _localCache = List.from(users);
  }
}
