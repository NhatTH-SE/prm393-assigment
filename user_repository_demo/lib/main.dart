import 'package:flutter/material.dart';
import 'data/datasources/user_datasource.dart';
import 'data/repositories/user_repository.dart';
import 'screens/user_screen.dart';

void main() {
  // Yêu cầu mở rộng: Khởi tạo các thành phần theo chuẩn Dependency Injection
  final apiDataSource = UserApiDataSource();
  final localDataSource = UserLocalDataSource();
  
  final userRepository = UserRepositoryImpl(
    apiDataSource: apiDataSource,
    localDataSource: localDataSource,
  );

  runApp(MyApp(repository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository repository;
  
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserScreen(repository: repository),
    );
  }
}
