import '../../models/user.dart';
import '../datasources/user_datasource.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({bool forceRefresh = false});
}

class UserRepositoryImpl implements UserRepository {
  final UserDataSource apiDataSource;
  final UserDataSource localDataSource;

  UserRepositoryImpl({
    required this.apiDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<User>> getUsers({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      // Yêu cầu mở rộng: Thêm cache logic
      final localData = await localDataSource.getUsers();
      if (localData.isNotEmpty) {
        print('✅ [Repository] Trả về dữ liệu từ Local Cache');
        return localData;
      }
    }

    print('🌐 [Repository] Cache trống hoặc force refresh, gọi API...');
    final apiData = await apiDataSource.getUsers();
    
    // Lưu vào cache
    await localDataSource.saveUsers(apiData);
    
    print('✅ [Repository] Trả về dữ liệu từ API');
    return apiData;
  }
}
