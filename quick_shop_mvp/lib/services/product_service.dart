import '../models/product.dart';
import '../data/data_source.dart';

class ProductService {
  List<Product> getAllProducts() {
    return rawProducts;
  }

  List<Product> filterByMaxPrice(double maxPrice) {
    return rawProducts.where((product) {
      return product.price < maxPrice;
    }).toList();
  }

  void handleAddToCart(Product product) {
    print("Đã chọn mua: ${product.name}");
    print("Giá tiền: ${product.price}");
  }

  double calculateTotalPrice(List<Product> products) {
    double total = 0;
    for (var p in products) {
      total += p.price;
    }
    return total;
  }
}
