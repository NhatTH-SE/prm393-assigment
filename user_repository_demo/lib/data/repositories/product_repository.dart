// Yêu cầu mở rộng: Tạo thêm ProductRepository
class Product {
  final int id;
  final String title;

  Product(this.id, this.title);
}

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(1, 'Product A'),
      Product(2, 'Product B'),
    ];
  }
}
